import SwiftBok

@Init()
@Members()
public struct StompSendError: Entity {
    public let description: String
    public let message: String?
}
