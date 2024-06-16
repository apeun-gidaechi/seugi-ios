import Domain
import Foundation

struct MessageRes: Decodable {
    let id: String?
    let chatRoomId: String
    let type: String
    let userId: Int
    let message: String
    let eventList: [Int]?
    let emoticon: String?
    let emojiList: [EmojiRes]
    let mention: [Int]
    let mentionAll: Bool
    let timestamp: Date?
    let read: [Int]
    let messageStatus: String
}
