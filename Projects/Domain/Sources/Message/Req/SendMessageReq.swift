public struct SendMessageReq: Encodable {
    public let roomId: String
    public let type: MessageType
    public let message: String
    public let mention: [Int]?
    public let mentionAll: Bool?
    public let emoticon: String?
    
    public init(roomId: String, type: MessageType, message: String, mention: [Int]?, mentionAll: Bool?, emoticon: String?) {
        self.roomId = roomId
        self.type = type
        self.message = message
        self.mention = mention
        self.mentionAll = mentionAll
        self.emoticon = emoticon
    }
}
