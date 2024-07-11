import Moya

public enum NoticeEndpoint: SeugiEndpoint {
    case getNotices(workspaceId: String)
}

public extension NoticeEndpoint {
    
    static let provider = MoyaProvider<NoticeEndpoint>(session: session)
    static let authProvider = MoyaProvider<NoticeEndpoint>(session: authSession)
    
    var host: String {
        "notice"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getNotices(let workspaceId):
                .get - "/\(workspaceId)" - .requestPlain
        }
    }
}
