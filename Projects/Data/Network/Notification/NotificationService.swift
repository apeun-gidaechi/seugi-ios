import Domain

final class NotificationService: Service<NotificationEndpoint>, NotificationRepo {
    func getNotifications(workspaceId: String) -> APIResult<Base<[Notification]>> {
        performRequest(.getNotifications(workspaceId: workspaceId), res: [Notification].self)
    }
    
    func postNotification(_ req: PostNotificationReq) -> APIResult<BaseVoid> {
        performRequest(.postNotification(req))
    }
    
    func updateNotification(_ req: UpdateNotificationReq) -> APIResult<BaseVoid> {
        performRequest(.updateNotification(req))
    }
    
    func removeNotification(workspaceId: String, id: Int) -> APIResult<BaseVoid> {
        performRequest(.removeNotification(workspaceId: workspaceId, id: id))
    }
    
    func emojiNotification(_ req: NotificationEmojiReq) -> APIResult<BaseVoid> {
        performRequest(.emojiNotification(req))
    }
}
