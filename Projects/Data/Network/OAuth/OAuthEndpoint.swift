import Domain
import Moya

enum OAuthEndpoint {
    case authenticateGoogle(GoogleCodeReq)
    case connectGoogle(GoogleCodeReq)
}

extension OAuthEndpoint: SeugiEndpoint {
    var host: String { "oauth" }
    var route: Route {
        switch self {
        case .authenticateGoogle(let req):
                .post("google/authenticate")
                .task(req.toJSONParameters())
        case .connectGoogle(let req):
                .post("google/connect")
                .task(req.toJSONParameters())
        }
    }
}
