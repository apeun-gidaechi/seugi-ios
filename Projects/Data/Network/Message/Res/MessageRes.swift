import Domain
import Foundation

struct MessageRes: SeugiResponse {
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
    
    func toEntity() -> Message {
        Message(
            id: id,
            chatRoomId: chatRoomId,
            type: .init(rawValue: type),
            userId: userId,
            message: message,
            eventList: eventList,
            emoticon: emoticon,
            emojiList: emojiList.map { $0.toEntity() },
            mention: mention,
            mentionAll: mentionAll,
            timestamp: timestamp,
            read: read,
            messageStatus: .init(rawValue: messageStatus)
        )
    }
}
