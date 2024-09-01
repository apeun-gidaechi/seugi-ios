import Combine

public protocol StompRepo {
    func openSocket()
    func closeSocket()
    func subDisconnect() -> AnyPublisher<Void, Never>
    func subConnect() -> AnyPublisher<Void, Never>
    func subSendReciept() -> AnyPublisher<String, Never>
    func subSendError() -> AnyPublisher<SendStompErrorEntity, Never>
    func subPing() -> AnyPublisher<Void, Never>
    func reissue(accessToken: String)
    func reconnect(time: Double)
}
