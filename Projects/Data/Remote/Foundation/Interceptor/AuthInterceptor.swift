import Foundation
import SwiftUI
import Combine
import UIKit

import Domain
import SwiftUtil

import Moya
import Alamofire

final class AuthInterceptor: Moya.RequestInterceptor {
    enum RefreshResult {
        case success, failure
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var actions: [(RefreshResult) -> Void] = []
    private var isRefreshing: Bool = false
    
    private var keyValueStore: KeyValueRepo
    private var keychainRepo: KeychainRepo
    
    init(
        keyValueStore: KeyValueRepo,
        keychainRepo: KeychainRepo
    ) {
        self.keyValueStore = keyValueStore
        self.keychainRepo = keychainRepo
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
        
        var modifiedRequest = urlRequest
        guard let accessToken: String = keyValueStore.load(key: .accessToken) else {
            completion(.success(urlRequest))
            Log.network("AuthInterceptor.adapt - accessToken is nil")
            return
        }
        Log.network("AuthInterceptor.adapt - Set token: \(accessToken)")
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        Log.network("AuthInterceptor.retry() called")
        guard request.retryCount <= 2 else {
            Log.network("AuthInterceptor - RetryCount가 2보다 큽니다")
            return
        }
        
        guard let url = request.request?.url else {
            Log.network("AuthInterceptor - Invalid URL")
            completion(.doNotRetryWithError(error))
            return
        }
        Log.network("AuthInterceptor - URL String: \(url.absoluteString)")
        
        guard let response = request.task?.response as? HTTPURLResponse else {
            Log.network("AuthInterceptor - Invalid Response")
            completion(.doNotRetryWithError(error))
            return
        }
        Log.network("AuthInterceptor - StatusCode: \(response.statusCode)")
        
        let refreshStatusCode = [403, 401]
        guard refreshStatusCode.contains(response.statusCode) else {
            Log.network("AuthInterceptor - Invalid StatusCode")
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let refreshToken = keychainRepo.load(key: .refreshToken) else {
            Log.network("❌ AuthInterceptor - Refresh Token is Empty")
            failureReissue()
            completion(.doNotRetryWithError(APIError.refreshFailure))
            return
        }
        
        Log.network("✅ AuthInterceptor - Try refresh with token - \(refreshToken)")
        
        if isRefreshing {
            self.actions.append { result in
                switch result {
                case .success:
                    completion(.retry)
                case .failure:
                    completion(.doNotRetryWithError(APIError.refreshFailure))
                }
            }
            return
        }
        
        self.isRefreshing = true
        DefaultNetRunner(
            provider: .init(
                plugins: [
                    NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
                ]
            ),
            decoder: .myDecoder
        )
            .deepDive(MemberEndpoint.refresh(token: refreshToken), res: Base<String>.self)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .sink { result in
                switch result {
                case .failure:
                    self.actions.forEach { action in
                        action(.failure)
                    }
                    
                    Log.network(error)
                    self.failureReissue()
                    Log.network("❌ AuthInterceptor - Refresh Failure")
                    completion(.doNotRetryWithError(APIError.refreshFailure))
                case .finished:
                    self.actions = []
                    self.isRefreshing = false
                }
            } receiveValue: {
                Log.network("✅ AuthInterceptor - Refresh Success")
                let accessToken = String($0.split(separator: " ")[1])
                self.keyValueStore.save(key: .accessToken, value: accessToken)
                
                self.actions.forEach { action in
                    action(.success)
                }
                completion(.retry)
            }.store(in: &subscriptions)
    }
    
    private func failureReissue() {
        keyValueStore.delete(key: .accessToken)
        keychainRepo.delete(key: .refreshToken)
    }
}
