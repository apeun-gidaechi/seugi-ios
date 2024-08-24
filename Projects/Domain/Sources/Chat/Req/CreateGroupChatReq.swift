import SwiftBok

@Init()
@Members()
public struct CreateGroupChatReq: Encodable {
    public let roomName: String
    public let workspaceId: String
    public let joinUsers: [Int]
    public let chatRoomImg: String
}
