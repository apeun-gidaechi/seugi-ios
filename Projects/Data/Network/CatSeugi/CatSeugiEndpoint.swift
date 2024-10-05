import Domain
import Moya

enum CatSeugiEndpoint {
    case sendMessage(CatSeugiSendMessageReq)
}

extension CatSeugiEndpoint: AIEndpoint {
    var host: String {
        "ai"
    }
    
    var route: Route {
        switch self {
        case .sendMessage(let req):
                .post()
                .task(req.toJSONParameters())
        }
    }
}
