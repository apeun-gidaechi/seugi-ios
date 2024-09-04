public struct ChatMemberEventReq: Encodable {
    public let chatRoomId: String?
    public let chatMemberUsers: [Int]
    
    public init(chatRoomId: String?, chatMemberUsers: [Int]) {
        self.chatRoomId = chatRoomId
        self.chatMemberUsers = chatMemberUsers
    }
}
