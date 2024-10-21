import Foundation
import DateUtil
import ScopeKit

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
    public var hasTimeLabel: Bool
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
        hasTimeLabel: Bool = false,
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
        self.hasTimeLabel = hasTimeLabel
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
    
    // - 이 코드는 왜 더러운가?
    // - 단기적 목표만 이루는 것을 추구하고 포트폴리오용 프로젝트를 양성하려는 학교 분위기 => 다가오는 마감기한, 리팩토링 부족, 그냥 서비스 전반 설계가 잘못됨.
    // - 나중에 삭제될 코드.
    func setupBotMessage(room: Room) -> Self {
        var message = self
        if message.type == .bot {
            let myDecoder = run {
                let d = JSONDecoder()
                d.dateDecodingStrategy = .custom { decoder in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)
                    
                    // If the prefix is ​​0000-, it means online.
                    if dateStr.hasPrefix("0001") {
                        return Date.distantPast
                    }
                    
                    let dateFormatters = DateFormatterType.allCases
                    if let date = dateFormatters.compactMap({ DateFormatter(type: $0).date(from: dateStr) }).first {
                        return date
                    } else {
                        let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
                        throw DecodingError.dataCorrupted(context)
                    }
                }
                return d
            }
            if let jsonData = message.message.data(using: .utf8),
               let botMessage = try? myDecoder.decode(BotMessage.self, from: jsonData) {
                switch botMessage.data {
                case .meal(let data):
                    message.message = data.map {
                        "- 오늘의 " + $0.mealType.rawValue + "\n" +
                        $0.menu.joined(separator: "\n")
                    }
                    .joined(separator: "\n\n")
                case .notification(let data):
                    message.message = run {
                        "\(data.userName) 선생님이 공지를 작성하셨어요\n" +
                        "제목: \(data.title)\n" +
                        data.content
                    }
                case .pickMember(let data):
                    let pattern = "::(\\d+)::"
                    if let regex = try? NSRegularExpression(pattern: pattern) {
                        let results = regex.matches(in: data, range: NSRange(data.startIndex..., in: data))
                        
                        // 결과에서 숫자만 추출
                        let numbers = results.map { result in
                            Int(String(data[Range(result.range(at: 1), in: data)!]))
                        }
                        message.message = "사람을 \(numbers.count)명 뽑았어요\n" +
                        numbers.compactMap { number in
                            room.joinUserInfo.map(\.userInfo).first {
                                $0.id == number
                            }?.name
                        }.joined(separator: " ")
                    }
                case .schedule(let data):
                    message.message = "오늘의 시간표에요\n" +
                    data.map {
                        "\($0.time)교시 : \($0.subject)"
                    }.joined(separator: "\n")
                    break
                case .teamBuilding(let data):
                    break
                case .etc(let data):
                    message.message = data
                }
            } else {
                print("Message.setupBotMessage decoding failure")
            }
        }
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
        case .message, .deleteMessage, .bot:
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

extension Message: Searchable {
    public var searchString: String {
        self.message
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
    
    func hasTimeLabel(at currentIndex: Int) -> Bool {
        let message = self[currentIndex]
        guard let messageTimestamp = message.timestamp else { return false }
        
        if currentIndex == self.count - 1 {
            return true
        }
        
        let nextMessage = self[currentIndex + 1]
        guard let nextMessageTimestamp = nextMessage.timestamp else { return false }
        
        return nextMessage.userId != message.userId || messageTimestamp.diff(to: nextMessageTimestamp, in: .minute) >= 1
    }
    
    func getFirstMessageTimestamp() -> Date? {
        return self.first?.timestamp
    }
    
    func sortedByTimestamp() -> Self {
        return self.sorted { $0.timestamp ?? .now < $1.timestamp ?? .now }
    }
}

public extension [Message] {
    /// isFirst, isLast값 대입
    func setupIsFirstAndIsLast() -> Self {
        var messages = self
        for index in messages.indices {
            messages[index].isFirst = self.isFirstMessage(at: index)
            messages[index].isLast = self.isLastMessage(at: index)
        }
        return messages
    }
    
    func setupHasTimelabel() -> Self {
        var messages = self
        for index in messages.indices {
            messages[index].hasTimeLabel = self.hasTimeLabel(at: index)
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
        
        let joinUserInfo = joinUserInfo.filter { !$0.isOnline } // 온라인이 아닌 유저만 카운트
        
        for i in 0..<messages.count {
            while userIndex < joinUserInfo.count && (messages[i].timestamp ?? .now) >= joinUserInfo[userIndex].timestamp {
                userIndex += 1
            }
            
            messages[i].unread = userIndex
        }
        return messages
    }
    
    func setupBotMessages(room: Room) -> [Message] {
        return self.map { $0.setupBotMessage(room: room) }
    }
}

private extension Date {
    func diff(to date: Date, in component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        let start = calendar.date(bySetting: .second, value: 0, of: self)!
        let end = calendar.date(bySetting: .second, value: 0, of: date)!
        
        guard let difference = calendar.dateComponents([component], from: start, to: end).value(for: component) else {
            return 0
        }
        
        return difference
    }
}
