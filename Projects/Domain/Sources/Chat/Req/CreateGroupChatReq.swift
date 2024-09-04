public struct CreateGroupChatReq: Encodable {
    public let roomName: String
    public let workspaceId: String
    public let joinUsers: [Int]
    public let chatRoomImg: String
    
    public init(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) {
        self.roomName = roomName
        self.workspaceId = workspaceId
        self.joinUsers = joinUsers
        self.chatRoomImg = chatRoomImg
    }
}
