import Foundation

public protocol MessageProtocol {
    var id: String? { get }
    var chatRoomId: String? { get }
    var type: `Type`? { get }
    var userId: Int { get }
    var message: String { get }
    var eventList: [Int]? { get }
    var emoticon: String? { get }
    var emojiList: [Emoji] { get }
    var mention: [Int] { get }
    var mentionAll: Bool { get }
    var timestamp: Date? { get }
    var uuid: String? { get }
    var messageStatus: ChatStatusEnum? { get }
}

public struct MessageRes: Entity, MessageProtocol {
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
    
    public func toDomain() -> Message {
        Message(
            id: id,
            chatRoomId: chatRoomId,
            type: type,
            userId: userId,
            message: message,
            eventList: eventList,
            emoticon: emoticon,
            emojiList: emojiList,
            mention: mention,
            mentionAll: mentionAll,
            timestamp: timestamp,
            uuid: uuid,
            messageStatus: messageStatus
        )
    }
}

public struct Message: Entity, MessageProtocol {
    public let id: String?
    public var chatRoomId: String?
    public var type: `Type`?
    public var userId: Int
    public var message: String
    public var eventList: [Int]?
    public var emoticon: String?
    public var emojiList: [Emoji]
    public var mention: [Int]
    public var mentionAll: Bool
    public var timestamp: Date?
    public var uuid: String?
    public var messageStatus: ChatStatusEnum?
    public var isFirst: Bool
    public var isLast: Bool
    public var joinUserCount: Int
    public var author: RetrieveMember?
    public var detailText: String?
    public var unread: Int
    
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
        messageStatus: ChatStatusEnum?,
        isFirst: Bool = false,
        isLast: Bool = false,
        joinUserCount: Int = 0,
        unread: Int = 0
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
        self.isFirst = isFirst
        self.isLast = isLast
        self.joinUserCount = joinUserCount
        self.unread = unread
    }
}

public extension Message {
    static func just(
        userId: Int,
        message: String,
        isFirst: Bool,
        isLast: Bool,
        joinUserCount: Int
    ) -> Self {
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
            messageStatus: .alive,
            isFirst: isFirst,
            isLast: isLast,
            joinUserCount: joinUserCount
        )
    }
    
    func setupAuthor(room: Room) -> Self {
        var message = self
        message.author = room.findUserOrUnknownUser(id: message.userId).userInfo
        return message
    }
    
    func setupDetailText(room: Room) -> Self {
        var message = self
        message.detailText = message.getDetailText(room: room)
        return message
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

public extension Array where Element: MessageProtocol {
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
    
    func sortedByTimestamp() -> Self {
        return self.sorted { $0.timestamp ?? .now < $1.timestamp ?? .now }
    }
}

public extension [Message] {
    func search(text: String) -> [Message] {
        self.filter { $0.message.contains(text) }
    }
    
    /// isFirst, isLast값 대입
    func setupIsFirstAndIsLast() -> Self {
        var messages = self
        for index in messages.indices {
            messages[index].isFirst = self.isFirstMessage(at: index)
            messages[index].isLast = self.isLastMessage(at: index)
        }
        return messages
    }
    
    func setupAuthor(room: Room) -> Self {
        return self.map { $0.setupAuthor(room: room) }
    }
    
    func setupDetailText(room: Room) -> Self {
        return self.map { $0.setupDetailText(room: room) }
    }
    
    func setupRead(joinUserInfo: [UserInfo]) -> Self {
        var messages = self
        var userIndex = 0

        for i in 0..<messages.count {
            while userIndex < joinUserInfo.count && (messages[i].timestamp ?? .now) >= joinUserInfo[userIndex].timestamp {
                userIndex += 1
            }
            
            messages[i].unread = userIndex
        }
        return messages
    }
}
