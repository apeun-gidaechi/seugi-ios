import Domain
import Combine

public final class FakeStompRepo: StompRepo {
    public func openSocket() {
        Log.info("🤩 FakeStompRepo.openSocket")
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
    
    public func subSendError() -> AnyPublisher<SendStompErrorEntity, Never> {
        Log.info("🤩 FakeStompRepo.subSendError")
        return [].publisher.eraseToAnyPublisher()
    }
    
    public func subPing() -> AnyPublisher<Void, Never> {
        Log.info("🤩 FakeStompRepo.subPing")
        return [].publisher.eraseToAnyPublisher()
    }
    
    public func reissue(accessToken: String) {
        Log.info("🤩 FakeStompRepo.reissue")
    }
    
    public func reconnect(time: Double) {
        Log.info("🤩 FakeStompRepo.reconned")
    }
    
    public func closeSocket() {
        Log.info("🤩 FakeStompRepo.closeSocket")
    }
    
    public init() {}
}
