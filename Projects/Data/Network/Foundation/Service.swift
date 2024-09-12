import Foundation
import Moya
import CombineMoya
import Combine
import Domain
import Then
import DateUtil

class Service<Target: BaseEndpoint> {
    
    func request<T: Decodable>(
        _ target: Target.Target,
        res: T.Type
    ) -> APIResult<T> {
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
                    value = try decoder.decode(T.self, from: result.data)
                } catch {
                   log("❌ Decoding Error - cause: \(error)")
                   throw APIError.unknown
                }
                return value
            }
            .mapError { error in // map error
                guard let error = error as? MoyaError,
                      let response = error.response else {
                    log("❌ Unknown Error")
                    return APIError.unknown
                }
                if case .underlying(let error, _) = error,
                   let error = error.asAFError,
                   case .requestRetryFailed(let retryError, _) = error,
                   let error = retryError as? APIError {
                    return error
                }
                self.responeLog(target: target, response: response)
                guard let error = try? decoder.decode(BaseVoid.self, from: response.data) else {
                    return APIError.unknown
                }
                return APIError.http(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func performRequest<T: Entity>(
        _ target: Target.Target,
        res: T.Type
    ) -> ObservableResult<Base<T>> {
        return request(target, res: Base<T>.self).observe()
    }
    
    func performRequest(
        _ target: Target.Target
    ) -> ObservableResult<BaseVoid> {
        return request(target, res: BaseVoid.self).observe()
    }
    
    private func requestLog(target: Target.Target) {
        log("🛰 NETWORK Reqeust LOG")
        log(
            "Method: \(target.method.rawValue)\n"
            + "URL: \(target.host)/\(target.path)\n"
            + "Header: \(target.headers ?? [:])\n"
            + "Method: \(target.method.rawValue)"
        )
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if case .requestJSONEncodable(let req) = target.task,
           let json = try? encoder.encode(req) {
            log("Body: \(String(data: json, encoding: .utf8) ?? "-")")
        } else if case .requestParameters(let parameters, _) = target.task,
                  let json = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) {
            log("Param: \(String(data: json, encoding: .utf8) ?? "-")")
        } else if case .uploadMultipart(let multiParts) = target.task {
            Array(multiParts.enumerated()).forEach { idx, data in
                log("MultiPart \(idx): name - \(data.name), fileName - \(data.fileName ?? ""), mimeType - \(data.mimeType ?? "")")
            }
        }
    }
    
    private func responeLog(target: Target.Target, response: Moya.Response) {
        log("🛰 NETWORK Response LOG")
        log(
            "URL: \(target.host)/\(target.path)" + "\n"
            + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "Data: \(response.data.toPrettyPrintedString ?? "")"
        )
    }
}
