import Combine

public protocol StompRepo {
    func openSocket()
    func closeSocket()
    func subStompEvet() -> AnyPublisher<StompEventEntity, Never>
    func reissue(accessToken: String)
    func reconnect(time: Double)
}
