struct CreateRoomReq: Encodable {
    let roomName: String
    let workspaceId: String
    let joinUsers: [Int]
    let chatRoomImg: String
}
