public struct OutJoinedRequest: Encodable {
    let roomId: Int
    let outJoinedUsers: [Int]
    
    public init(roomId: Int, outJoinedUsers: [Int]) {
        self.roomId = roomId
        self.outJoinedUsers = outJoinedUsers
    }
}
