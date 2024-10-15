public typealias StompHeaders = [String: String]
public enum StompEventEntity {
    case stompClient(body: String?, header: StompHeaders?, destination: String)
    case stompClientDidDisconnect
    case stompClientDidConnect
    case serverDidSendReceipt(receiptId: String)
    case serverDidSendError(StompSendErrorEntity)
    case serverDidSendPing
}
