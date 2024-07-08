import Domain

public final class MessageService: Service<MessageEndpoint> {
   
}

extension MessageService: MessageRepo {
    public func getMessages(roomId: String, page: Int, size: Int) -> APIResult<Base<GetMessage>> {
        performRequest(.getMessages(roomId: roomId, page: page, size: size), res: GetMessageRes.self)
    }
}

extension MessageService: StompRepo {
    public func openSocket() {
        stomp.openSocket()
    }
    
    public func subDisconnect() -> AnyPublisher<Void, Never> {
        <#code#>
    }
    
    public func subConnect() -> AnyPublisher<Void, Never> {
        <#code#>
    }
    
    public func subSendReciept() -> AnyPublisher<String, Never> {
        <#code#>
    }
    
    public func subSendError() -> AnyPublisher<Domain.StompSendError, Never> {
        <#code#>
    }
    
    public func subPing() -> AnyPublisher<Void, Never> {
        <#code#>
    }
    
    
//    func openSocket() {
//        stomp.openSocket()
//    }
//    
//    func sendMessage(roomId: String, type: MessageType, message: String, mention: [Int]?, mentionAll: Bool?, emoticon: String?) {
//        let req = SendMessageReq(
//            roomId: roomId,
//            type: type,
//            message: message,
//            mention: mention,
//            mentionAll: mentionAll,
//            emoticon: emoticon
//        )
//        stomp.sendJSONForDict(dict: req, to: "/exchange/chat.exchange/room.\(roomId)")
//    }
}
