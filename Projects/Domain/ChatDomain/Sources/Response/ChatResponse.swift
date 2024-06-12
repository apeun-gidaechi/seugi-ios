import ChatDomainInterface
import DateUtil

public struct ChatResponse: Decodable {
    let id: Int
    let type: String
    let chatName: String
    let containUserCnt: Int
    let createdAt: String
    let chatStatusEnum: String
}

public extension ChatResponse {
    func toDomain() -> Chat {
        Chat(
            id: id,
            type: RoomType(rawValue: type),
            chatName: chatName,
            containUserCnt: containUserCnt,
            createdAt: createdAt.localDateTime ?? .now,
            chatStatusEnum: ChatStatus(rawValue: chatStatusEnum)
        )
    }
}
