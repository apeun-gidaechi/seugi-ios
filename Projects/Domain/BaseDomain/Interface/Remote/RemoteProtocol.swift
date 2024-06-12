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
    
    var decoder: JSONDecoder { get }
    
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
    
    var decoder: JSONDecoder {
        .init()
    }
    
    @discardableResult
    func request(
        target: MoyaProvider<Target>.Target,
        isAuthorization: Bool = true
    ) async throws -> Moya.Response {
        let p = isAuthorization ? authProvider : provider
        return try await withUnsafeThrowingContinuation { continuation in
            p.request(target) { result in
                switch result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
