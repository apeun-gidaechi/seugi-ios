import Alamofire
import UIKit
import Foundation
import UserDefaultInterface
import DIContainerInterface
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
        
        let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        guard !refreshToken.isEmpty else {
            failureReissue()
            completion(.doNotRetryWithError(error))
            return
        }
        
        print("✅ refresh 시도")
        
//        AF.request(
//            "\(Grow.baseUrl)/auth/reissue",
//            method: .post,
//            parameters: ["refreshToken": refreshToken],
//            encoding: JSONEncoding.default
//        )
//        .responseJSON {
//            switch $0.result {
//            case .success(let value):
//                guard let json = value as? [String: Any] else {
//                    completion(.doNotRetryWithError(error))
//                    return
//                }
//                let data = json["data"] as? [String: Any]
//                let accessToken = data?["accessToken"]
//                guard let accessToken else {
//                    completion(.doNotRetryWithError(error))
//                    return
//                }
//                print("✅ refresh 성공")
//                UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
//                completion(.retry)
//            case .failure(let error):
//                print("❌ \(error.localizedDescription)")
//                print("❌ refresh 실패")
//                failureReissue()
//                completion(.doNotRetryWithError(error))
//            }
//        }
    }
    
    private func failureReissue() {
        //
    }
}
