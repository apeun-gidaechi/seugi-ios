public struct NotificationEmoji: Entity {
    public var emoji: String
    public var userList: [Int]
    
    public init(emoji: String, userList: [Int]) {
        self.emoji = emoji
        self.userList = userList
    }
}
