struct ChatMemberEventReq: Encodable {
    let chatRoomId: String?
    let chatMemberUsers: [Int]
}
