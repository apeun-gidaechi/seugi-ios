import Moya
import Foundation

public protocol SeugiEndpoint: TargetType {
    associatedtype Target: SeugiEndpoint
    var host: String { get }
    var route: (Moya.Method, String, Moya.Task) { get }
    var authorization: Authorization { get }
    static var provider: MoyaProvider<Target> { get }
    static var authProvider: MoyaProvider<Target> { get }
}

public enum Authorization {
    case authorization
    case none
}

public extension SeugiEndpoint {
    static var session: Session {
        Session()
    }
    static var authSession: Session {
        Session(interceptor: AuthInterceptor())
    }
    var baseURL: URL {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseUrl") as? String ?? ""
        return URL(string: baseUrl)!
            .appendingPathComponent(host)
    }
    
    var path: String {
        route.1
    }
    
    var method: Moya.Method {
        route.0
    }
    
    var task: Moya.Task {
        route.2
    }
    
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
    var authorization: Authorization {
        .authorization
    }
}

infix operator - : AdditionPrecedence
func - (method: Moya.Method, path: String) -> (Moya.Method, String) {
    return (method, path)
}

func - (m: (Moya.Method, String), task: Moya.Task) -> (Moya.Method, String, Moya.Task) {
    return (m.0, m.1, task)
}
