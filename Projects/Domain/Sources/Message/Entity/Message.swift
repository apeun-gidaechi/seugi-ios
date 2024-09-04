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
