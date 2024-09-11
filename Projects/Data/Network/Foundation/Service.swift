import Foundation
import Moya
import CombineMoya
import Combine
import Domain
import Then
import DateUtil

public let decoder = JSONDecoder().then { decoder in
    
    let localDateTimeMSFormatter = DateFormatter("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
    let localDateTimeFormatter = DateFormatter("yyyy-MM-dd'T'HH:mm:ss")
    let localDateFormatter = DateFormatter("yyyy-MM-dd")
    
    decoder.dateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        var dateStr = try container.decode(String.self)
        
        if dateStr.count > 26 {
            dateStr = String(dateStr[0..<26])
        }
        
        return if let date = localDateTimeMSFormatter.date(from: dateStr) {
            date
        } else if let date = localDateTimeFormatter.date(from: dateStr) {
            date
        } else if let date = localDateFormatter.date(from: dateStr) {
            date
        } else {
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
            throw DecodingError.dataCorrupted(context)
        }
    }
}
class Service<Target: SeugiEndpoint> {
    
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
    ) -> APIResult<Base<T>> {
        return request(target, res: Base<T>.self)
            .asResult()
    }
    
    func performRequest(
        _ target: Target.Target
    ) -> APIResult<BaseVoid> {
        return request(target, res: BaseVoid.self)
            .asResult()
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
