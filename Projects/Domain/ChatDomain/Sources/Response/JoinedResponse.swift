import ChatDomainInterface

public struct JoinedResponse: Decodable {
    let chatRoomId: Int
    let workspaceId: String
    let roomType: String
    let roomAdmin: Int
    let joinUserId: [Int]
}

public extension JoinedResponse {
    func toDomain() -> Joined {
        Joined(
            chatRoomId: chatRoomId,
            workspaceId: workspaceId,
            roomType: .init(rawValue: roomType), 
            roomAdmin: roomAdmin,
            joinUserId: joinUserId
        )
    }
}
