import Foundation
import SwiftUtil
import Moya
import CombineMoya
import Combine
import Domain
import Secret

protocol Service {
    associatedtype Target: SeugiEndpoint
    var decoder: JSONDecoder { get }
    
    func request<T: Decodable>(
        _ target: Target.Target,
        res: T.Type
    ) -> AnyPublisher<T, APIError>
}

extension Service {
    
    var decoder: JSONDecoder {
        .init()
    }
    
    func request<T: Decodable>(
        _ target: Target.Target,
        res: T.Type = BaseVoidRes.self
    ) -> AnyPublisher<T, APIError> {
        return (target.authorization == .authorization ? Target.authProvider : Target.provider)
            .requestPublisher(target)
            .filterSuccessfulStatusCodes() // 200..<300
            .tryMap { result in // map response
                guard let value = try? decoder.decode(T.self, from: result.data) else {
                    throw APIError.unknown
                }
                return value
            }
            .mapError { error in // map error
                guard let error = error as? MoyaError,
                      let data = error.response?.data else {
                    return APIError.unknown
                }
                guard let error = try? decoder.decode(BaseVoidRes.self, from: data) else {
                    return APIError.unknown
                }
                return APIError.http(error.toEntity())
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
