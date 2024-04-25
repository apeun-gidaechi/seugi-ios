import ChatDomainInterface

public struct AddJoinedResponse: Decodable {
    let chatRoomId: Int
    let roomType: String
    let joinUserId: [Int]
}

public extension AddJoinedResponse {
    func toDomain() -> AddJoined {
        AddJoined(
            chatRoomId: chatRoomId,
            roomType: .init(rawValue: roomType),
            joinUserId: joinUserId
        )
    }
}
