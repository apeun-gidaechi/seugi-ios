import SwiftBok

@Init()
@Members()
public struct MessageEvent: Entity {
    public let type: `Type`?
    public let userId: Int?
    public let eventList: [Int]
    public let messageId: String?
}
