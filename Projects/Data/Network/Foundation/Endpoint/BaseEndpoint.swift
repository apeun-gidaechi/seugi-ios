import Moya

public protocol BaseEndpoint: TargetType {
    associatedtype Target: BaseEndpoint
    var host: String { get }
    var route: (Moya.Method, String, Moya.Task) { get }
    var authorization: Authorization { get }
    static var provider: MoyaProvider<Target> { get }
    static var authProvider: MoyaProvider<Target> { get }
}
