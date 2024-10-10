import Foundation
import Domain

public enum PostNotificationType: Equatable {
    case createNotification
    case updateNotification(Domain.Notification)
}
