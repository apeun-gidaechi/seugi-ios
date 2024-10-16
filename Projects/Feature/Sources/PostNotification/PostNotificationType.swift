import Foundation
import Domain

enum PostNotificationType: Equatable {
    case createNotification
    case updateNotification(Domain.Notification)
}
