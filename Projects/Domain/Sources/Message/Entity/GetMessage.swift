public struct GetMessageRes: Entity {
    public let firstMessageId: String?
    public let messages: [MessageRes]
    
    public init(firstMessageId: String?, messages: [MessageRes]) {
        self.firstMessageId = firstMessageId
        self.messages = messages
    }
}

public struct GetMessage: Entity {
    public let firstMessageId: String?
    public let messages: [Message]
    
    public init(firstMessageId: String?, messages: [Message]) {
        self.firstMessageId = firstMessageId
        self.messages = messages
    }
}
