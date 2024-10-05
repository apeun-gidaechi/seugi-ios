import Foundation
import Combine

import Domain
import SwiftUtil

import Moya
import CombineMoya

/// NetRunner
/// NetRunner가 deinit 되면 provider도 deinit됨.
/// provider가 deinit되면 request가 cancel됨.
public protocol NetRunner {
    var provider: MoyaProvider<AnyEndpoint> { get }
    var authProvider: MoyaProvider<AnyEndpoint> { get }
    var decoder: JSONDecoder { get }
    
    func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type,
        completion: @escaping (Result<DTO, APIError>) -> Void
    )
    
    func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) -> AnyPublisher<DTO, APIError>
    
    func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) -> AnyPublisher<Result<DTO, APIError>, Never>
    
    func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) async -> Result<DTO, APIError>
    
    func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) async throws -> DTO
}

public class DefaultNetRunner: NetRunner {
    public let provider: MoyaProvider<AnyEndpoint>
    public let authProvider: MoyaProvider<AnyEndpoint>
    public let decoder: JSONDecoder
    
    public init(
        provider: MoyaProvider<AnyEndpoint>,
        authProvider: MoyaProvider<AnyEndpoint>,
        decoder: JSONDecoder
    ) {
        self.provider = provider
        self.authProvider = authProvider
        self.decoder = decoder
    }
    
    private func selectProvider(_ target: BaseEndpoint) -> MoyaProvider<AnyEndpoint> {
        switch target.authorization {
        case .none:
            provider
        case .refresh:
            authProvider
        }
    }
    
    public func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type,
        completion: @escaping (Result<DTO, APIError>) -> Void
    ) {
        selectProvider(target).request(AnyEndpoint(target)) { result in
            switch result {
            case .success(let response):
                let response = self.unwrapThrowable {
                    try response.filterSuccessfulStatusCodes()
                        .map(res, using: self.decoder)
                }.mapError { $0.toAPIError(using: self.decoder) }
                completion(response)
            case .failure(let error):
                completion(.failure(error.toAPIError(using: self.decoder)))
            }
        }
    }
    
    public func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) -> AnyPublisher<DTO, APIError> {
        return selectProvider(target)
            .requestPublisher(AnyEndpoint(target))
            .filterSuccessfulStatusCodes() // 200..<300
            .map(DTO.self, using: decoder)
            .mapError { $0.toAPIError(using: self.decoder) }
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
    
    public func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) -> AnyPublisher<Result<DTO, APIError>, Never> {
        return selectProvider(target)
            .requestPublisher(AnyEndpoint(target))
            .filterSuccessfulStatusCodes()
            .map(DTO.self, using: decoder)
            .map { Result.success($0) }
            .catch { Just(Result.failure($0.toAPIError(using: self.decoder))) }
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
    
    public func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) async -> Result<DTO, APIError> {
        return await selectProvider(target)
            .request(AnyEndpoint(target))
            .flatMap { response in
                unwrapThrowable {
                    try response
                        .filterSuccessfulStatusCodes()
                        .map(res, using: decoder)
                }
            }
            .mapError { $0.toAPIError(using: decoder) }
    }
    
    public func deepDive<DTO: Decodable>(
        _ target: BaseEndpoint,
        res: DTO.Type
    ) async throws -> DTO {
        do {
            return try await selectProvider(target)
                .request(AnyEndpoint(target))
                .filterSuccessfulStatusCodes()
                .map(res, using: decoder)
        } catch {
            throw error.toAPIError(using: decoder)
        }
    }
    
    private func unwrapThrowable<T>(
        throwable: () throws -> T
    ) -> Result<T, MoyaError> {
        do {
            return .success(try throwable())
        } catch {
            if let moyaError = error as? MoyaError {
                return .failure(moyaError)
            } else {
                return .failure(.underlying(error, nil))
            }
        }
    }
}

private extension Error {
    func toAPIError(using decoder: JSONDecoder) -> APIError {
        guard let error = self as? MoyaError,
              let response = error.response else {
            return APIError.unknown
        }
        if case .underlying(let error, _) = error,
           let error = error.asAFError,
           case .requestRetryFailed(let retryError, _) = error,
           let error = retryError as? APIError {
            return error
        }
        guard let error = try? decoder.decode(BaseVoid.self, from: response.data) else {
            return APIError.unknown
        }
        return APIError.http(error)
    }
}
