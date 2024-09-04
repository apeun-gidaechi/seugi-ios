import Foundation

public struct Notification: Entity {
    public let id: Int
    public let workspaceId: String
    public let userId: Int
    public let userName: String
    public let title: String
    public let content: String
    public let emoji: [NotificationEmoji]
    public let creationDate: Date?
    public let lastModifiedDate: Date?
    
    public init(id: Int, workspaceId: String, userId: Int, userName: String, title: String, content: String, emoji: [NotificationEmoji], creationDate: Date?, lastModifiedDate: Date?) {
        self.id = id
        self.workspaceId = workspaceId
        self.userId = userId
        self.userName = userName
        self.title = title
        self.content = content
        self.emoji = emoji
        self.creationDate = creationDate
        self.lastModifiedDate = lastModifiedDate
    }
}
