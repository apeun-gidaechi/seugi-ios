//
//  RemoteProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

public protocol RemoteProtocol {
    
    associatedtype Target: TargetType
    
    var provider: MoyaProvider<Target> { get }
    
    var authProvider: MoyaProvider<Target> { get }
    
    func request(
        target: MoyaProvider<Target>.Target,
        isAuthorization: Bool
    ) async throws -> Moya.Response
}

public extension RemoteProtocol {
    
    var provider: MoyaProvider<Target> {
        .init(
            session: Session(eventMonitors: [APIEventLogger()])
        )
    }
    
    var authProvider: MoyaProvider<Target> {
        .init(
            session: Session(interceptor: AuthInterceptor(), eventMonitors: [APIEventLogger()])
        )
    }
    
    @discardableResult
    func request(
        target: MoyaProvider<Target>.Target,
        isAuthorization: Bool = true
    ) async throws -> Moya.Response {
        let p = isAuthorization ? authProvider : provider
        let response = try await withUnsafeThrowingContinuation { continuation in
            p.request(target) { result in
                switch result {
                case let .success(data):
                    print("✅ success")
                    print("Response JSON : " + (data.data.toPrettyPrintedString ?? "-"))
                    continuation.resume(returning: data)
                case let .failure(error):
                    print("✅ failure")
                    print(
                        "URL: " + (error.response?.request?.url?.absoluteString ?? "") + "\n"
                        + "StatusCode: " + "\(error.response?.response?.statusCode ?? 0)" + "\n"
                        + "Data: \(error.response?.data.toPrettyPrintedString ?? "")"
                    )
                    continuation.resume(throwing: error)
                }
            }
        }
        return response
    }
}
