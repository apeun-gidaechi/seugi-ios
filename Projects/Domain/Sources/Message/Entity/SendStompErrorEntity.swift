public struct StompSendErrorEntity: Entity {
    public let description: String
    public let message: String?
    
    public init(description: String, message: String?) {
        self.description = description
        self.message = message
    }
}
