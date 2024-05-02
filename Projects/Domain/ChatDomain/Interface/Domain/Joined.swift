public struct Joined {
    public let chatRoomId: Int
    public let workspaceId: String
    public let roomType: RoomType?
    public let roomAdmin: Int
    public let joinUserId: [Int]
    
    public init(
        chatRoomId: Int,
        workspaceId: String,
        roomType: RoomType?,
        roomAdmin: Int,
        joinUserId: [Int]
    ) {
        self.chatRoomId = chatRoomId
        self.workspaceId = workspaceId
        self.roomType = roomType
        self.roomAdmin = roomAdmin
        self.joinUserId = joinUserId
    }
}
