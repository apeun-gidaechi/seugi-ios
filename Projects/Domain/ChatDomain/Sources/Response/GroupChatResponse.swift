public struct GroupChatResponse: Decodable {
    let id: Int
    let type: String
    let chatName: String
    let containUserCnt: Int
    let createdAt: String
    let chatStatusEnum: String
}
