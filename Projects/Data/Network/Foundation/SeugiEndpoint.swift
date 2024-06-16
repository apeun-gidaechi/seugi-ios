import Moya
import Foundation
import Secret

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
        Session(eventMonitors: [APIEventLogger()])
    }
    static var authSession: Session {
        Session(interceptor: AuthInterceptor(), eventMonitors: [APIEventLogger()])
    }
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
