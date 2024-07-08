import Domain

struct SendMessageReq: Encodable {
    let roomId: String
    let type: MessageType
    let message: String
    let mention: [Int]?
    let mentionAll: Bool?
    let emoticon: String?
}
