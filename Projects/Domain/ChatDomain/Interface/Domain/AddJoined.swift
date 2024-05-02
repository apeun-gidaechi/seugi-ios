public struct AddJoined {
    public let chatRoomId: Int
    public let roomType: RoomType?
    public let joinUserId: [Int]
    
    public init(
        chatRoomId: Int,
        roomType: RoomType?,
        joinUserId: [Int]
    ) {
        self.chatRoomId = chatRoomId
        self.roomType = roomType
        self.joinUserId = joinUserId
    }
}
