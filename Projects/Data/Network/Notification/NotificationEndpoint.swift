import Domain
import Moya

enum NotificationEndpoint {
    case getNotifications(workspaceId: String)
    case postNotification(PostNotificationReq)
    case updateNotification(UpdateNotificationReq)
    case removeNotification(workspaceId: String, id: Int)
    case emojiNotification(NotificationEmojiReq)
}

extension NotificationEndpoint: SeugiEndpoint {
    var host: String { "notification" }
    var route: Route {
        switch self {
        case .getNotifications(let workspaceId):
            return .get("\(workspaceId)")
                .task(.requestPlain)
        case .postNotification(let req):
            return .post()
                .task(req.toJSONParameters())
        case .updateNotification(let req):
            return .patch()
                .task(req.toJSONParameters())
        case .removeNotification(let workspaceId, let id):
            return .delete("\(workspaceId)/\(id)")
        case .emojiNotification(let req):
            return .patch("emoji")
                .task(req.toJSONParameters())
        }
    }
}
