import Foundation

import Moya

public protocol SeugiEndpoint: BaseEndpoint {}

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
