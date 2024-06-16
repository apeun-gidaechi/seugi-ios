import Foundation
import SwiftUtil
import Moya
import CombineMoya
import Combine
import Domain
import Secret

public class Service<Target: SeugiEndpoint> {
    
    var decoder = JSONDecoder()
    
    func request<T: Decodable>(
        _ target: Target.Target,
        res: T.Type
    ) -> AnyPublisher<T, APIError> {
        return (target.authorization == .authorization ? Target.authProvider : Target.provider)
            .requestPublisher(target)
            .filterSuccessfulStatusCodes() // 200..<300
            .tryMap { result in // map response
                guard let value = try? self.decoder.decode(T.self, from: result.data) else {
                    throw APIError.unknown
                }
                return value
            }
            .mapError { error in // map error
                guard let error = error as? MoyaError,
                      let data = error.response?.data else {
                    return APIError.unknown
                }
                guard let error = try? self.decoder.decode(BaseVoidRes.self, from: data) else {
                    return APIError.unknown
                }
                return APIError.http(error.toEntity())
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func performRequest<T: Decodable & EntityMappable>(
        _ target: Target.Target,
        res: T.Type
    ) -> APIResult<Base<T.Entity>> {
        return request(target, res: BaseRes<T>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func performRequest(
        _ target: Target.Target
    ) -> APIResult<BaseVoid> {
        return request(target, res: BaseVoidRes.self)
            .map { $0.toEntity() }
            .asResult()
    }
}
