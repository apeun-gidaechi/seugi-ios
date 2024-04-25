public struct JoinedResponse: Decodable {
    let chatRoomId: Int
    let workspaceId: String
    let roomType: String
    let roomAdmin: Int
    let joinUserId: [Int]
}
