import Domain
import Combine

public final class FakeStompRepo: StompRepo {
    public func closeSocket() {
        //
    }
    
    public func openSocket() {
        log("🤩 FakeStompRepo.openSocket")
    }
    
    public func subDisconnect() -> AnyPublisher<Void, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func subConnect() -> AnyPublisher<Void, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func subSendReciept() -> AnyPublisher<String, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func subSendError() -> AnyPublisher<Domain.SendStompErrorEntity, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func subPing() -> AnyPublisher<Void, Never> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public init() {}
}
