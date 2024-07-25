public enum NotificationDestination: Hashable {
    case createNotification
    case updateNotification(id: Int)
}
