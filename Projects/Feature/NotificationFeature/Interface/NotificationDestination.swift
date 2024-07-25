import Domain

public enum NotificationDestination: Hashable {
    case createNotification
    case updateNotification(Domain.Notification)
}
