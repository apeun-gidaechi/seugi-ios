import Foundation
import Moya

enum MessageEndpoint {
    case getMessages(roomId: String, timestamp: Date?)
}

extension MessageEndpoint: SeugiEndpoint {
    var host: String { "message" }
    var route: Route {
        switch self {
        case .getMessages(let roomId, let timestamp):
            return .get("search/\(roomId)")
                .task(["size": timestamp].toURLParameters())
        }
    }
}
