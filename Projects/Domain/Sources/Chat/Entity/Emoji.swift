import SwiftBok

@PublicInit
@PublicMembers
public struct Emoji: Entity {
    public let emojiId: Int?
    public let userId: [Int]
}
