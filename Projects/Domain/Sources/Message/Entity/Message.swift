import Foundation

public struct Message: Entity {
    public let id: String?
    public let chatRoomId: String?
    public let type: `Type`?
    public let userId: Int
    public let message: String
    public let eventList: [Int]?
    public let emoticon: String?
    public let emojiList: [Emoji]
    public let mention: [Int]
    public let mentionAll: Bool
    public let timestamp: Date?
    public let uuid: String?
    public let messageStatus: ChatStatusEnum?
    
    public init(
        id: String?,
        chatRoomId: String?,
        type: Type?,
        userId: Int,
        message: String,
        eventList: [Int]?,
        emoticon: String?,
        emojiList: [Emoji],
        mention: [Int],
        mentionAll: Bool,
        timestamp: Date?,
        uuid: String?,
        messageStatus: ChatStatusEnum?
    ) {
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
        self.uuid = uuid
        self.messageStatus = messageStatus
    }
}

public extension Message {
    static func just(userId: Int, message: String) -> Self {
        Message(
            id: nil,
            chatRoomId: "",
            type: .message,
            userId: userId,
            message: message,
            eventList: [],
            emoticon: nil,
            emojiList: [],
            mention: [],
            mentionAll: false,
            timestamp: .now,
            uuid: UUID().uuidString,
            messageStatus: .alive
        )
    }
}

public extension Message {
    enum ViewType: Entity {
        case text
        case image
        case file
        case detail
    }
    
    var viewType: ViewType? {
        switch self.type {
        case .message, .deleteMessage:
                .text
        case .img:
                .image
        case .file:
                .file
        case .enter, .left, .transferAdmin:
                .detail
        default:
            nil
        }
    }
    
    func getDetailText(room: Room) -> String? {
        guard let userId = eventList?.first,
              let eventCount = self.eventList?.count,
                eventCount > 1,
              let firstMemberName = room.findUser(id: userId)?.userInfo.name else {
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
        || self[currentIndex - 1].userId != message.userId
    }
    
    func isLastMessage(at currentIndex: Int) -> Bool {
        let message = self[currentIndex]
        return currentIndex == self.count - 1 
        || self[currentIndex + 1].userId != message.userId
    }
    
    func getFirstMessageTimestamp() -> Date? {
        return self.first?.timestamp
    }
    
    func search(text: String) -> [Message] {
        self.filter { $0.message.contains(text) }
    }
}
