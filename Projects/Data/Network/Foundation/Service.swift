import Foundation
import SwiftUtil
import Moya
import CombineMoya
import Combine
import Domain

public class Service<Target: SeugiEndpoint> {
    
    private let decoder = JSONDecoder()
    
    func request<T: Decodable>(
        _ target: Target.Target,
        res: T.Type
    ) -> AnyPublisher<T, APIError> {
        self.requestLog(target: target)
        
        let provider = switch target.authorization {
        case .authorization: Target.authProvider
        case .none: Target.provider
        }
        
        return provider
            .requestPublisher(target)
            .filterSuccessfulStatusCodes() // 200..<300
            .tryMap { result in // map response
                self.responeLog(target: target, response: result)
                let value: T
                do {
                    value = try self.decoder.decode(T.self, from: result.data)
                } catch {
                   print("❌ Decoding Error - cause: \(error)")
                   throw APIError.unknown
                }
                return value
            }
            .mapError { error in // map error
                guard let error = error as? MoyaError,
                      let response = error.response else {
                    print("❌ Unknown Error")
                    return APIError.unknown
                }
                if case .underlying(let error, _) = error,
                   let error = error.asAFError,
                   case .requestRetryFailed(let retryError, _) = error,
                   let error = retryError as? APIError {
                    return error
                }
                self.responeLog(target: target, response: response)
                guard let error = try? self.decoder.decode(BaseVoidRes.self, from: response.data) else {
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
    
    private func requestLog(target: Target.Target) {
        print("🛰 NETWORK Reqeust LOG")
        print(
            "URL: \(target.host)/\(target.path)\n"
            + "Header: \(target.headers ?? [:])\n"
            + "Method: \(target.method.rawValue)"
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if case .requestJSONEncodable(let req) = target.task,
           let json = try? encoder.encode(req) {
            print("Body: \(String(data: json, encoding: .utf8) ?? "-")")
        } else if case .requestParameters(let parameters, _) = target.task,
                  let json = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) {
            print("Body: \(String(data: json, encoding: .utf8) ?? "-")")
        }
    }
    
    private func responeLog(target: Target.Target, response: Moya.Response) {
        print("🛰 NETWORK Response LOG")
        print(
            "URL: \(target.host)/\(target.path)" + "\n"
            + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "Data: \(response.data.toPrettyPrintedString ?? "")"
        )
    }
}
