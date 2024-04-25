public struct CreateChatRequest: Encodable {
    let workspaceId: String
    let roomName: String
    let chatRoomImg: String
    let joinUsers: [Int]
    
    public init(workspaceId: String, roomName: String, chatRoomImg: String, joinUsers: [Int]) {
        self.workspaceId = workspaceId
        self.roomName = roomName
        self.chatRoomImg = chatRoomImg
        self.joinUsers = joinUsers
    }
}
