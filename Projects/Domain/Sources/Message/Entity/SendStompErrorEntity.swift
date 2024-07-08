import SwiftBok

@Init()
@Members()
public struct SendStompErrorEntity: Entity {
    public let description: String
    public let message: String?
}
