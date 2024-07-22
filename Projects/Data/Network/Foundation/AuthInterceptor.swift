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
        print("✅ AuthInterceptor - Set token \(accessToken)")
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        print("✅ AuthInterceptor - Start refresh")
        guard request.retryCount <= 3 else {
            print("❌ AuthInterceptor - RetryCount가 3보다 큽니다")
            return
        }
        
        guard let url = request.request?.url else {
            print("❌ AuthInterceptor - Invalid URL")
            completion(.doNotRetryWithError(error))
            return
        }
        print("✅ AuthInterceptor - URL String: \(url.absoluteString)")
        let refreshStatusCode = [403, 401]
        guard let response = request.task?.response as? HTTPURLResponse, refreshStatusCode.contains(response.statusCode) else {
            print("❌ AuthInterceptor - Invalid Response or StatusCode")
            completion(.doNotRetryWithError(error))
            return
        }
        print("✅ AuthInterceptor - StatusCode: \(response.statusCode)")
        
        let refreshToken = keyValueStore.load(key: .refreshToken) ?? ""
        guard !refreshToken.isEmpty else {
            print("❌ AuthInterceptor - Refresh Token is Empty")
            failureReissue()
            completion(.doNotRetryWithError(APIError.refreshFailure))
            return
        }
        
        print("✅ AuthInterceptor - Try refresh with token - \(refreshToken)")
        
        memberRepo.refresh(token: refreshToken)
            .sink { [self] result in
                switch result {
                case .success(let res):
                    print("✅ AuthInterceptor - Refresh Success")
                    keyValueStore.save(key: .accessToken, value: res.data)
                    completion(.retry)
                case .failure(let error):
                    print(error)
                    failureReissue()
                    print("❌ AuthInterceptor - Refresh Failure")
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
