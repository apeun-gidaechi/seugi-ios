import Foundation
import SwiftBok

@Init()
@Members()
public struct GetMessage: Entity {
    public let firstMessageId: String?
    public let messages: [Message]
}

