import Foundation
import SwiftBok

@Init()
@Members()
public struct Notification: Entity {
    public let id: Int
    public let workspaceId: String
    public let userName: String
    public let title: String
    public let content: String
    public let emoji: [NotificationEmoji]
    public let creationDate: Date?
    public let lastModifiedDate: Date?
}
