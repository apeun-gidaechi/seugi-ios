import Foundation

public struct UserInfo: Entity {
    public let userInfo: RetrieveMember
    public var timestamp: Date
    
    public init(userInfo: RetrieveMember, timestamp: Date) {
        self.userInfo = userInfo
        self.timestamp = timestamp
    }
}
