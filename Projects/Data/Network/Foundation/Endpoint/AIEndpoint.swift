import Moya
import Foundation

public protocol AIEndpoint: TargetType {
    associatedtype Target: AIEndpoint
    var host: String { get }
    var route: (Moya.Method, String, Moya.Task) { get }
    static var provider: MoyaProvider<Target> { get }
}

public extension AIEndpoint {
    static var session: Session {
        Session()
    }
    var baseURL: URL {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "AIBaseUrl") as? String ?? ""
        print("baseurl - \(baseUrl)")
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
}
