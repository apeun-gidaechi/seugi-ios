import Foundation
import Moya

extension Encodable {
    func toRequestParameters(encoding: ParameterEncoding) -> Moya.Task {
        if let data = try? JSONEncoder().encode(self),
           let object = (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
           )).flatMap({ $0 as? [String: Any] }) {
            let parameters = object.mapValues { value -> Any in
                if let enumValue = value as? (any RawRepresentable) {
                    return enumValue.rawValue
                }
                return value
            }
            return .requestParameters(
                parameters: parameters,
                encoding: encoding
            )
        }
        return .requestPlain
    }
    
    func toJSONParameters() -> Moya.Task {
        toRequestParameters(encoding: JSONEncoding.default)
    }
    
    func toURLParameters() -> Moya.Task {
        toRequestParameters(encoding: URLEncoding.default)
    }
}
