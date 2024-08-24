import SwiftBok

@Init()
@Members()
public struct SendMessageReq: Encodable {
    public let roomId: String
    public let type: MessageType
    public let message: String
    public let mention: [Int]?
    public let mentionAll: Bool?
    public let emoticon: String?
}
