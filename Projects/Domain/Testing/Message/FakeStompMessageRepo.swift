import Domain
import Combine

public final class FakeStompMessageRepo: StompMessageRepo {
    public func sendMessage(roomId: String, type: Domain.MessageType, message: String, mention: [Int]?, mentionAll: Bool?, emoticon: String?) {
        debugPrint("💎 FakeStompMessageRepo.sendMessage")
    }
    
    public func subGetMessage(roomId: String) -> AnyPublisher<Message, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func unsubGetMessage(roomId: String) {
        debugPrint("💎 FakeStompMessageRepo.unsubGetMessage - roomId: \(roomId)")
    }
    
    public init() {}
}
