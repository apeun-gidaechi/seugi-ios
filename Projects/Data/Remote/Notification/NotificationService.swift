import Domain

final class NotificationService: NotificationRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func getNotifications(workspaceId: String) -> APIResult<Base<[Notification]>> {
        runner.deepDive(NotificationEndpoint.getNotifications(workspaceId: workspaceId), res: Base<[Notification]>.self)
    }
    
    func postNotification(_ req: PostNotificationReq) -> APIResult<BaseVoid> {
        runner.deepDive(NotificationEndpoint.postNotification(req), res: BaseVoid.self)
    }
    
    func updateNotification(_ req: UpdateNotificationReq) -> APIResult<BaseVoid> {
        runner.deepDive(NotificationEndpoint.updateNotification(req), res: BaseVoid.self)
    }
    
    func removeNotification(workspaceId: String, id: Int) -> APIResult<BaseVoid> {
        runner.deepDive(NotificationEndpoint.removeNotification(workspaceId: workspaceId, id: id), res: BaseVoid.self)
    }
    
    func emojiNotification(_ req: NotificationEmojiReq) -> APIResult<BaseVoid> {
        runner.deepDive(NotificationEndpoint.emojiNotification(req), res: BaseVoid.self)
    }
}
