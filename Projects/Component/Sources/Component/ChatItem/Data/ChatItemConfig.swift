import Foundation

import Domain

public struct ChatItemConfig {
    public let message: Message
    public let isFirst: Bool
    public let isLast: Bool
    public let joinUserCount: Int
    
    public init(message: Message, isFirst: Bool, isLast: Bool, joinUserCount: Int) {
        self.message = message
        self.isFirst = isFirst
        self.isLast = isLast
        self.joinUserCount = joinUserCount
    }
}
