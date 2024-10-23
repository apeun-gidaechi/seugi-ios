import Domain
import Moya

enum CatSeugiEndpoint {
    case sendMessage(SendMessageReq)
}

extension CatSeugiEndpoint: SeugiEndpoint {
    var host: String { "ai" }
    var route: Route {
        switch self {
        case .sendMessage(let req):
                .post()
                .task(req.toJSONParameters())
        }
    }
}
