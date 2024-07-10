import Combine
import ApeunStompKit

public protocol StompMessageRepo {
    func sendMessage(roomId: String, type: MessageType, message: String, mention: [Int]?, mentionAll: Bool?, emoticon: String?)
    func subGetMessage(roomId: String) -> AnyPublisher<GetMessage, StompError>
    func unsubGetMessage(roomId: String)
}
