public protocol NotificationRepo {
    func getNotifications(workspaceId: String) -> APIResult<Base<[Notification]>>
    func postNotification(_ req: PostNotificationReq) -> APIResult<BaseVoid>
    func updateNotification(_ req: UpdateNotificationReq) -> APIResult<BaseVoid>
    func removeNotification(workspaceId: String, id: Int) -> APIResult<BaseVoid>
    func emojiNotification(_ req: NotificationEmojiReq) -> APIResult<BaseVoid>
}
