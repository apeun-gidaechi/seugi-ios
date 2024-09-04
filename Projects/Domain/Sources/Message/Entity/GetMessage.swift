public struct GetMessage: Entity {
    public let firstMessageId: String?
    public let messages: [Message]
    
    public init(firstMessageId: String?, messages: [Message]) {
        self.firstMessageId = firstMessageId
        self.messages = messages
    }
}
