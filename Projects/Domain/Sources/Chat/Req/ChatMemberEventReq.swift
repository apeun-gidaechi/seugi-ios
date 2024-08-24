import SwiftBok

@Init()
@Members()
public struct ChatMemberEventReq: Encodable {
    public let chatRoomId: String?
    public let chatMemberUsers: [Int]
}
