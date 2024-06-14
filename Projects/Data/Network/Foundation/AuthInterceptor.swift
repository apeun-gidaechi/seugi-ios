import Alamofire
import UIKit
import Foundation
import Domain
import DIContainer
import Secret
import SwiftUI

public struct AuthInterceptor: RequestInterceptor {
    
    @Inject private var keyValueStore: any KeyValueStore
    
    public init() {}
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("✅ 토큰 장착")
        var modifiedRequest = urlRequest
        let accessToken = keyValueStore.load(key: .accessToken) ?? ""
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("✅ refresh 시작")
        guard let url = request.request?.url else {
            completion(.doNotRetryWithError(error))
            return
        }
        print("✅ URL String: \(url.absoluteString)")
        print("✅ StatusCode = \((request.task?.response as? HTTPURLResponse)?.statusCode ?? 999)")
        let refreshStatusCode = 401
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == refreshStatusCode, !url.absoluteString.contains("reissue") else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let refreshToken = keyValueStore.load(key: .refreshToken) ?? ""
        guard !refreshToken.isEmpty else {
            failureReissue()
            completion(.doNotRetryWithError(error))
            return
        }
        
        print("✅ refresh 시도")
        
        AF.request(
            "\(Secret.baseURL)/member/refresh",
            method: .get,
            parameters: ["token": refreshToken],
            encoding: URLEncoding.default
        ).responseJSON {
            switch $0.result {
            case .success(let value):
                guard let json = value as? [String: Any] else {
                    completion(.doNotRetryWithError(error))
                    return
                }
                let data = json["data"] as? [String: Any]
                let accessToken = data?["accessToken"]
                guard let accessToken else {
                    completion(.doNotRetryWithError(error))
                    return
                }
                print("✅ refresh 성공")
                keyValueStore.save(key: .accessToken, value: accessToken)
                completion(.retry)
            case .failure(let error):
                print("❌ \(error.localizedDescription)")
                print("❌ refresh 실패")
                failureReissue()
                completion(.doNotRetryWithError(error))
            }
        }
    }
    
    private func failureReissue() {
        keyValueStore.delete(key: .accessToken)
        keyValueStore.delete(key: .refreshToken)
    }
}
