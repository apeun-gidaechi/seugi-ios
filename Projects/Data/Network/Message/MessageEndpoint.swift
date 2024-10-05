import Moya

enum MessageEndpoint {
    case getMessages(roomId: String, page: Int, size: Int)
}

extension MessageEndpoint: SeugiEndpoint {
    var host: String { "message" }
    var route: Route {
        switch self {
        case .getMessages(let roomId, let page, let size):
            return .get("search/\(roomId)")
                .task(["page": page, "size": size].toURLParameters())
        }
    }
}
