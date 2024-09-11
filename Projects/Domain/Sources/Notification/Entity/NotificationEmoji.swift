public struct NotificationEmoji: Entity {
    public let emoji: String
    public let userId: [Int]
    
    public init(emoji: String, userId: [Int]) {
        self.emoji = emoji
        self.userId = userId
    }
}
