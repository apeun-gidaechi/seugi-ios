import Foundation
import PublicInit

@PublicInit
public struct Message: Entity {
    public let id: String?
    public let chatRoomId: String
    public let type: `Type`
    public let userId: Int
    public let message: String
    public let eventList: [Int]?
    public let emoticon: String?
    public let emojiList: [Emoji]
    public let mention: [Int]
    public let mentionAll: Bool
    public let timestamp: Date?
    public let read: [Int]
    public let messageStatus: ChatStatusEnum
}
