import Moya

public enum MessageEndpoint: SeugiEndpoint {
    case getMessages(roomId: String, page: Int, size: Int)
}

public extension MessageEndpoint {
    
    static let provider = MoyaProvider<MessageEndpoint>(session: session)
    static let authProvider = MoyaProvider<MessageEndpoint>(session: authSession)
    
    var host: String {
        "message"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getMessages(let roomId, let page, let size):
                .get - "search/\(roomId)" - ["page": page, "size": size].toURLParameters()
        }
    }
}
