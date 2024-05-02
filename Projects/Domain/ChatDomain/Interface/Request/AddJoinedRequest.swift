public struct AddJoinedRequest: Encodable {
    let chatRoomId: Int
    let joinUserIds: [Int]
    
    public init(chatRoomId: Int, joinUserIds: [Int]) {
        self.chatRoomId = chatRoomId
        self.joinUserIds = joinUserIds
    }
}
