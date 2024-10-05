import Domain

import Moya

enum OAuthEndpoint: SeugiEndpoint {
    case authenticateGoogle(GoogleCodeReq)
    case connectGoogle(GoogleCodeReq)
}

extension OAuthEndpoint {
    static let authProvider: MoyaProvider<Self> = .init(session: session)
    static let provider: MoyaProvider<Self> = .init(session: authSession)
    
    var host: String {
        "oauth"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .authenticateGoogle(let req):
                .post - "google/authenticate" - req.toJSONParameters()
        case .connectGoogle(let req):
                .post - "google/connect" - req.toJSONParameters()
        }
    }
}
