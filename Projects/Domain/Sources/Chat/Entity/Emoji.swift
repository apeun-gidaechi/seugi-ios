import PublicInit

@PublicInit
public struct Emoji: Entity {
    public let emojiId: Int?
    public let userId: [Int]
}
