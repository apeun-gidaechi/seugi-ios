public protocol NotificationRepo {
    func getNotifications(workspaceId: String) -> ObservableResult<Base<[Notification]>>
    func postNotification(_ req: PostNotificationReq) -> ObservableResult<BaseVoid>
    func updateNotification(_ req: UpdateNotificationReq) -> ObservableResult<BaseVoid>
    func removeNotification(workspaceId: String, id: Int) -> ObservableResult<BaseVoid>
    func emojiNotification(_ req: NotificationEmojiReq) -> ObservableResult<BaseVoid>
}
