import Domain

final class NotificationService: Service<NotificationEndpoint>, NotificationRepo {
    func getNotifications(workspaceId: String) -> ObservableResult<Base<[Notification]>> {
        performRequest(.getNotifications(workspaceId: workspaceId), res: [Notification].self)
    }
    
    func postNotification(_ req: PostNotificationReq) -> ObservableResult<BaseVoid> {
        performRequest(.postNotification(req))
    }
    
    func updateNotification(_ req: UpdateNotificationReq) -> ObservableResult<BaseVoid> {
        performRequest(.updateNotification(req))
    }
    
    func removeNotification(workspaceId: String, id: Int) -> ObservableResult<BaseVoid> {
        performRequest(.removeNotification(workspaceId: workspaceId, id: id))
    }
    
    func emojiNotification(_ req: NotificationEmojiReq) -> ObservableResult<BaseVoid> {
        performRequest(.emojiNotification(req))
    }
}
