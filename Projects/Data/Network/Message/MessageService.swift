import Domain

final class MessageService: Service<MessageEndpoint>, MessageRepo {
    func getMessages(roomId: String, page: Int, size: Int) -> APIResult<Base<GetMessage>> {
        performRequest(.getMessages(roomId: roomId, page: page, size: size), res: GetMessageRes.self)
    }
}
