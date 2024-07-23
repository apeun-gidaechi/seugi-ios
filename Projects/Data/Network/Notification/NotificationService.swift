import Domain

final class NotificationService: Service<NotificationEndpoint>, NotificationRepo {
    func getNotifications(workspaceId: String) -> APIResult<Base<[Notification]>> {
        performRequest(.getNotifications(workspaceId: workspaceId), res: [NoticeRes].self)
    }
    
    func createNotification(title: String, content: String, workspaceId: String) -> APIResult<BaseVoid> {
        performRequest(.createNotification(.init(title: title, content: content, workspaceId: workspaceId)))
    }
    
    func updateNotification(id: Int, title: String, content: String) -> APIResult<BaseVoid> {
        performRequest(.updateNotification(.init(id: id, title: title, content: content)))
    }
    
    func removeNotification(workspaceId: String, id: Int) -> APIResult<BaseVoid> {
        performRequest(.removeNotification(workspaceId: workspaceId, id: id))
    }
}
