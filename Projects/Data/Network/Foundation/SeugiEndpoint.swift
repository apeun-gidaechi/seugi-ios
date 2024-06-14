import Moya
import Foundation
import Secret

protocol SeugiEndpoint: TargetType {
    var host: String { get }
    var route: (Moya.Method, String) { get }
    var authorization: Authorization { get }
}

enum Authorization {
    case authorization
    case none
}

extension SeugiEndpoint {
    var baseURL: URL {
        URL(string: Secret.baseURL)!
            .appendingPathComponent(host)
    }
    
    var path: String {
        route.1
    }
    
    var method: Moya.Method {
        route.0
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var authorization: Authorization {
        .authorization
    }
}

infix operator - : AdditionPrecedence
func - (method: Moya.Method, path: String) -> (Moya.Method, String) {
    return (method, path)
}
