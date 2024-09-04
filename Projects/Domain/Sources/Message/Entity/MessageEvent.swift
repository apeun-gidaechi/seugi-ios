public struct MessageEvent: Entity {
    public let type: `Type`?
    public let userId: Int?
    public let eventList: [Int]
    public let messageId: String?
    
    public init(type: `Type`?, userId: Int?, eventList: [Int], messageId: String?) {
        self.type = type
        self.userId = userId
        self.eventList = eventList
        self.messageId = messageId
    }
}
