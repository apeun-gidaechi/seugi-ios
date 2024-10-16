import Foundation

public struct UserInfo: Entity {
    public let userInfo: RetrieveMember
    public var timestamp: Date
    
    public init(userInfo: RetrieveMember, timestamp: Date) {
        self.userInfo = userInfo
        self.timestamp = timestamp
    }
    
    public var isOnline: Bool {
        return self.timestamp == .distantPast
    }
}

public extension [UserInfo] {
    var onlineMemberCount: Int {
        return self.filter {
            $0.isOnline
        }.count
    }
}
