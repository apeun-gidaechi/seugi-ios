import Domain
import Moya

enum OAuthEndpoint {
    case authenticateGoogle(GoogleCodeReq)
    case connectGoogle(GoogleCodeReq)
    case authenticateApple(AppleCodeReq)
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
        case .authenticateApple(let req):
                .post("apple/authenticate")
                .task(req.toJSONParameters())
        }
    }
}
