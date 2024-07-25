public protocol NotificationRepo {
    func getNotifications(workspaceId: String) -> APIResult<Base<[Notification]>>
    func postNotification(title: String, content: String, workspaceId: String) -> APIResult<BaseVoid>
    func updateNotification(id: Int, title: String, content: String) -> APIResult<BaseVoid>
    func removeNotification(workspaceId: String, id: Int) -> APIResult<BaseVoid>
}
