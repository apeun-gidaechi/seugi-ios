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
    public func getMessages(roomId: String, timestamp: Date?) -> APIResult<Base<GetMessageRes>> {
        runner.deepDive(MessageEndpoint.getMessages(roomId: roomId, timestamp: timestamp), res: Base<GetMessageRes>.self)
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
    
    public func subStompEvet() -> AnyPublisher<StompEventEntity, Never> {
        stomp.subject.eraseToAnyPublisher()
            .map { event in
                switch event {
                case .stompClient(let body, let header, let destination):
                        .stompClient(body: body, header: header, destination: destination)
                case .stompClientDidDisconnect:
                        .stompClientDidDisconnect
                case .stompClientDidConnect:
                        .stompClientDidConnect
                case .serverDidSendReceipt(let receiptId):
                        .serverDidSendReceipt(receiptId: receiptId)
                case .serverDidSendError(let description, let message):
                        .serverDidSendError(.init(description: description, message: message))
                case .serverDidSendPing:
                        .serverDidSendPing
                }
            }
            .eraseToAnyPublisher()
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
    
    public func subGetMessage(roomId: String) -> AnyPublisher<MessageRes, Never> {
        stomp.subBody(destination: "/exchange/chat.exchange/room.\(roomId)", res: MessageRes.self)
            .eraseToAnyPublisher()
    }
    
    public func unsubGetMessage(roomId: String) {
        stomp.unsubscribe(destination: "/exchange/chat.exchange/room.\(roomId)")
    }
}
