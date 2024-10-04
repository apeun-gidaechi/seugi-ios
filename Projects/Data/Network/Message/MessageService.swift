import Domain
import ApeunStompKit
import Combine

final class MessageService: Service<MessageEndpoint> {
    private let stomp = ApeunStompService.shared.stomp
}

// MARK: - HTTP Protocol
extension MessageService: MessageRepo {
    public func getMessages(roomId: String, page: Int, size: Int) -> APIResult<Base<GetMessage>> {
        performRequest(.getMessages(roomId: roomId, page: page, size: size), res: GetMessage.self)
    }
}

// MARK: - Stomp Protocol
extension MessageService: StompRepo {
    
    func openSocket() {
        stomp.openSocket()
    }
    
    public func closeSocket() {
        stomp.disconnect()
    }
    
    public func subDisconnect() -> AnyPublisher<Void, Never> {
        stomp.subDisconnect()
    }
    
    public func subConnect() -> AnyPublisher<Void, Never> {
        stomp.subConnect()
    }
    
    public func subSendReciept() -> AnyPublisher<String, Never> {
        stomp.subSendReceipt()
    }
    
    public func subSendError() -> AnyPublisher<SendStompErrorEntity, Never> {
        stomp.subSendError()
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    public func subPing() -> AnyPublisher<Void, Never> {
        stomp.subPing()
    }
    
    public func reissue(accessToken: String) {
        stomp.connectionHeaders?["Authorization"] = "Bearer \(accessToken)"
    }
    
    public func reconnect(time: Double) {
        stomp.reconnect(time: time)
    }
}

extension MessageService: StompMessageRepo {
    public func sendMessage(roomId: String, type: MessageType, message: String, mention: [Int]?, mentionAll: Bool?, emoticon: String?) {
        let req = SendMessageReq(roomId: roomId, type: type, message: message, mention: mention, mentionAll: mentionAll, emoticon: emoticon)
        stomp.sendJSONForDict(dict: req, to: "/pub/chat.message")
    }
    
    public func subGetMessage(roomId: String) -> AnyPublisher<Message, Never> {
        stomp.subBody(destination: "/exchange/chat.exchange/room.\(roomId)", res: Message.self)
            .eraseToAnyPublisher()
    }
    
    public func unsubGetMessage(roomId: String) {
        stomp.unsubscribe(destination: "/exchange/chat.exchange/room.\(roomId)")
    }
}
