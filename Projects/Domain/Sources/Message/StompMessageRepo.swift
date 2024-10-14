import Combine

public protocol StompMessageRepo {
    func sendMessage(_ req: SendMessageReq)
    func subGetMessage(roomId: String) -> AnyPublisher<MessageRes, Never>
    func unsubGetMessage(roomId: String)
}
