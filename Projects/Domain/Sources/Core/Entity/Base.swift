public struct Base<DATA: Entity>: Entity {
    public let status: Int
    public let success: Bool
    public let state: String
    public let message: String
    public let data: DATA
    
    public init(status: Int, success: Bool, state: String, message: String, data: DATA) {
        self.status = status
        self.success = success
        self.state = state
        self.message = message
        self.data = data
    }
}

public struct BaseVoid: Entity, Equatable {
    public let status: Int
    public let success: Bool
    public let state: String
    public let message: String
    
    public init(status: Int, success: Bool, state: String, message: String) {
        self.status = status
        self.success = success
        self.state = state
        self.message = message
    }
}
