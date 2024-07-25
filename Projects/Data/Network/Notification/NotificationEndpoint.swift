import Moya

enum NotificationEndpoint: SeugiEndpoint {
    case getNotifications(workspaceId: String)
    case createNotification(CreateNotificationReq)
    case updateNotification(UpdateNotificationReq)
    case removeNotification(workspaceId: String, id: Int)
}

extension NotificationEndpoint {
    
    static let provider = MoyaProvider<NotificationEndpoint>(session: session)
    static let authProvider = MoyaProvider<NotificationEndpoint>(session: authSession)
    
    var host: String {
        "notification"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getNotifications(let workspaceId):
                .get - "\(workspaceId)" - .requestPlain
        case .createNotification(let req):
                .post - "" - req.toJSONParameters()
        case .updateNotification(let req):
                .patch - "" - req.toJSONParameters()
        case .removeNotification(workspaceId: let workspaceId, id: let id):
                .delete - "\(workspaceId)/\(id)" - .requestPlain
        }
    }
}