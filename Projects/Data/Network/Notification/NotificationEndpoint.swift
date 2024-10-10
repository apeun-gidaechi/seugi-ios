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
                .get("\(workspaceId)")
                .task(.requestPlain)
        case .postNotification(let req):
                .post()
                .task(req.toJSONParameters())
        case .updateNotification(let req):
                .patch()
                .task(req.toJSONParameters())
        case .removeNotification(let workspaceId, let id):
                .delete("\(workspaceId)/\(id)")
        case .emojiNotification(let req):
                .patch("emoji")
                .task(req.toJSONParameters())
        }
    }
}
