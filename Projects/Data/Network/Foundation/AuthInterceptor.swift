import Alamofire
import UIKit
import Foundation
import Domain
import DIContainer
import SwiftUI
import Combine
import Moya

public final class AuthInterceptor: Moya.RequestInterceptor {
    
    @Inject private var keyValueStore: any KeyValueRepo
    @Inject private var memberRepo: MemberRepo
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init() {}
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
        
        var modifiedRequest = urlRequest
        guard let accessToken: String = keyValueStore.load(key: .accessToken) else {
            completion(.success(urlRequest))
            return
        }
        print("✅ Set token \(accessToken)")
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("✅ Start refresh")
        guard let url = request.request?.url else {
            completion(.doNotRetryWithError(error))
            return
        }
        print("✅ URL String: \(url.absoluteString)")
        let refreshStatusCode = [403, 401]
        guard let response = request.task?.response as? HTTPURLResponse, refreshStatusCode.contains(response.statusCode) else {
            completion(.doNotRetryWithError(error))
            return
        }
        print("✅ StatusCode = \(response.statusCode)")
        
        let refreshToken = keyValueStore.load(key: .refreshToken) ?? ""
        guard !refreshToken.isEmpty else {
            failureReissue()
            completion(.doNotRetryWithError(APIError.refreshFailure))
            return
        }
        
        print("✅ Try refresh with token - \(refreshToken)")
        
        memberRepo.refresh(token: refreshToken)
            .sink { [self] result in
                switch result {
                case .success(let res):
                    print("✅ Refresh Success")
                    keyValueStore.save(key: .accessToken, value: res.data)
                    completion(.retry)
                case .failure(let error):
                    print(error)
                    failureReissue()
                    print("❌ Refresh Failure")
                    completion(.doNotRetryWithError(APIError.refreshFailure))
                case .fetching:
                    break
                }
            }
            .store(in: &subscriptions)
    }
    
    private func failureReissue() {
        keyValueStore.delete(key: .accessToken)
        keyValueStore.delete(key: .refreshToken)
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}
