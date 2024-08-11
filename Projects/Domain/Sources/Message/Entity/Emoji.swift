import SwiftBok

@Init()
@Members()
public struct Emoji: Entity {
    public let emojiId: Int?
    public let userId: [Int]
}
