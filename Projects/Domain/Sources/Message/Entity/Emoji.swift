public struct Emoji: Entity {
    public let emojiId: Int?
    public let userId: [Int]
    
    public init(emojiId: Int?, userId: [Int]) {
        self.emojiId = emojiId
        self.userId = userId
    }
}
