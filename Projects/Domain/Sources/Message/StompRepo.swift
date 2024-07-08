import Combine

public protocol StompRepo {
    func openSocket()
    func subDisconnect() -> AnyPublisher<Void, Never>
    func subConnect() -> AnyPublisher<Void, Never>
    func subSendReciept() -> AnyPublisher<String, Never>
    func subSendError() -> AnyPublisher<StompSendError, Never>
    func subPing() -> AnyPublisher<Void, Never>
}
