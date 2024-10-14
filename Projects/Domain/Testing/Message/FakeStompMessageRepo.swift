import Domain
import Combine
import SwiftUtil

public final class FakeStompMessageRepo: StompMessageRepo {
    public func sendMessage(
        _ req: SendMessageReq
    ) {
        Log.info("💎 FakeStompMessageRepo.sendMessage")
    }
    
    public func subGetMessage(roomId: String) -> AnyPublisher<MessageRes, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func unsubGetMessage(roomId: String) {
        Log.info("💎 FakeStompMessageRepo.unsubGetMessage - roomId: \(roomId)")
    }
    
    public init() {}
}
