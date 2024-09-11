public struct NotificationEmoji: Entity {
    public let emoji: String
    public let userList: [Int]
    
    public init(emoji: String, userList: [Int]) {
        self.emoji = emoji
        self.userList = userList
    }
}
