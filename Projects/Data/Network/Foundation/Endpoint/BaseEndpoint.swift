import Moya

public protocol BaseEndpoint: TargetType {
    var host: String { get }
    var route: Route { get }
    var authorization: Authorization { get }
}

public extension BaseEndpoint {
    /**
     Devide route
     */
    var path: String {
        route.path
    }
    var method: Moya.Method {
        route.method
    }
    var task: Moya.Task {
        route.task
    }
    
    /**
     Just default value.
     You can change another value.
     */
    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }
    var validationType: ValidationType {
        .successCodes
    }
    var authorization: Authorization {
        .refresh
    }
}
