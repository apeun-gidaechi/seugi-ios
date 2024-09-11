import Moya

public enum EmailEndpoint: SeugiEndpoint {
    case send(email: String)
}

public extension EmailEndpoint {
    
    static var provider = MoyaProvider<Self>(session: session)
    static var authProvider = MoyaProvider<Self>(session: authSession)
    
    var host: String {
        "email"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .send(let email):
                .get - "send" - ["email": email].toURLParameters()
        }
    }
}
