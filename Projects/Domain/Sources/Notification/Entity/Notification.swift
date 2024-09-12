import Foundation

public struct Notification: Entity {
    public let id: Int
    public var workspaceId: String
    public var userId: Int
    public var userName: String
    public var title: String
    public var content: String
    public var emoji: [NotificationEmoji]
    public var creationDate: Date?
    public var lastModifiedDate: Date?
    
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
