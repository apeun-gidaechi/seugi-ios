import Foundation

public struct NotificationEmojiReq: Encodable {
    public let emoji: String
    public let notificationId: Int
    
    public init(emoji: String, notificationId: Int) {
        self.emoji = emoji
        self.notificationId = notificationId
    }
}
