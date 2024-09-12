import Foundation

public struct Message: Entity {
    public let id: String?
    public let chatRoomId: String
    public let type: `Type`?
    public let userId: Int
    public let message: String
    public let eventList: [Int]?
    public let emoticon: String?
    public let emojiList: [Emoji]
    public let mention: [Int]
    public let mentionAll: Bool
    public let timestamp: Date?
    public let read: [Int]
    public let messageStatus: ChatStatusEnum?
    
    public init(id: String?, chatRoomId: String, type: Type?, userId: Int, message: String, eventList: [Int]?, emoticon: String?, emojiList: [Emoji], mention: [Int], mentionAll: Bool, timestamp: Date?, read: [Int], messageStatus: ChatStatusEnum?) {
        self.id = id
        self.chatRoomId = chatRoomId
        self.type = type
        self.userId = userId
        self.message = message
        self.eventList = eventList
        self.emoticon = emoticon
        self.emojiList = emojiList
        self.mention = mention
        self.mentionAll = mentionAll
        self.timestamp = timestamp
        self.read = read
        self.messageStatus = messageStatus
    }
}

public extension Message {
    
    var isDetailText: Bool {
        switch type {
        case .enter, .left, .transferAdmin: true
        default: false
        }
    }
    
    func getDetailText(room: Room) -> String? {
        guard let userId = eventList?.first,
              let eventCount = self.eventList?.count,
                eventCount > 1,
              let firstMemberName = room.findUser(id: userId)?.name else {
            return nil
        }
        return switch type {
        case .enter:
            "\(firstMemberName) 외 \(eventCount - 1)명이 채팅방에 입장 했습니다"
        case .left:
            "\(firstMemberName)님이 채팅방에서 나갔습니다"
        case .transferAdmin:
            "\(firstMemberName)님이 채팅방 방장이 되었습니다"
        default:
            nil
        }
    }
}

public extension [Message] {
    func isFirstMessage(at currentIndex: Int) -> Bool {
        let message = self[currentIndex]
        return currentIndex == 0
        || (self[currentIndex - 1].userId != message.userId)
        || ![.message, .deleteMessage].contains(self[currentIndex - 1].type)
    }
    
    func isLastMessage(at currentIndex: Int) -> Bool {
        let message = self[currentIndex]
        return currentIndex == self.count - 1 || self[currentIndex + 1].userId != message.userId
    }
}
