import Combine
import Foundation
import Domain
import ApeunStompKit

final class MessageService {
    private let stomp = ApeunStompService.shared.stomp
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
}

// MARK: - HTTP Protocol
extension MessageService: MessageRepo {
    public func getMessages(roomId: String, timestamp: Date?) -> APIResult<Base<GetMessage>> {
        runner.deepDive(MessageEndpoint.getMessages(roomId: roomId, timestamp: timestamp), res: Base<GetMessage>.self)
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
    public func sendMessage(_ req: SendMessageReq) {
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
