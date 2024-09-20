import Alamofire
import UIKit
import Foundation
import Domain
import DIContainer
import SwiftUI
import Combine
import Moya
import SwiftUtil

final class AuthInterceptor: Moya.RequestInterceptor {
    
    @Inject private var keyValueStore: KeyValueRepo
    @Inject private var keychainRepo: KeychainRepo
    @Inject private var memberRepo: MemberRepo
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {}
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
        
        var modifiedRequest = urlRequest
        guard let accessToken: String = keyValueStore.load(key: .accessToken) else {
            completion(.success(urlRequest))
            return
        }
        log("✅ AuthInterceptor - Set token: \(accessToken)")
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        log("✅ AuthInterceptor - Start refresh")
        guard request.retryCount <= 2 else {
            log("❌ AuthInterceptor - RetryCount가 2보다 큽니다")
            return
        }
        
        guard let url = request.request?.url else {
            log("❌ AuthInterceptor - Invalid URL")
            completion(.doNotRetryWithError(error))
            return
        }
        log("✅ AuthInterceptor - URL String: \(url.absoluteString)")
        
        guard let response = request.task?.response as? HTTPURLResponse else {
            log("❌ AuthInterceptor - Invalid Response")
            completion(.doNotRetryWithError(error))
            return
        }
        log("✅ AuthInterceptor - StatusCode: \(response.statusCode)")
        
        let refreshStatusCode = [403, 401]
        guard refreshStatusCode.contains(response.statusCode) else {
            log("❌ AuthInterceptor - Invalid StatusCode")
            completion(.doNotRetryWithError(error))
            return
        }
        
        let refreshToken = keychainRepo.load(key: .refreshToken) ?? ""
        guard !refreshToken.isEmpty else {
            log("❌ AuthInterceptor - Refresh Token is Empty")
            failureReissue()
            completion(.doNotRetryWithError(APIError.refreshFailure))
            return
        }
        
        log("✅ AuthInterceptor - Try refresh with token - \(refreshToken)")
        
        memberRepo.refresh(token: refreshToken)
            .success { res in
                log("✅ AuthInterceptor - Refresh Success")
                let accessToken = String(res.data.split(separator: " ")[1])
                self.keyValueStore.save(key: .accessToken, value: accessToken)
                completion(.retry)
            }
            .failure { _ in
                log(error)
                self.failureReissue()
                log("❌ AuthInterceptor - Refresh Failure")
                completion(.doNotRetryWithError(APIError.refreshFailure))
            }.observe(&subscriptions)
    }
    
    private func failureReissue() {
        keyValueStore.delete(key: .accessToken)
        keychainRepo.delete(key: .refreshToken)
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}
