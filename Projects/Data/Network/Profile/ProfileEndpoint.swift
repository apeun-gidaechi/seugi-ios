import Moya
import Domain

public enum ProfileEndpoint: SeugiEndpoint {
    case me(workspaceId: String)
    case others(workspaceId: String, memberId: String)
}

public extension ProfileEndpoint {
    
    static let provider = MoyaProvider<ProfileEndpoint>(session: session)
    static let authProvider = MoyaProvider<ProfileEndpoint>(session: authSession)
    
    var host: String {
        "profile"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .me(let workspaceId):
                .get - "me" - ["workspaceId": workspaceId].toURLParameters()
        case .others(let workspaceId, let memberId):
                .get - "others" - ["workspaceId": workspaceId, "memberId": memberId].toURLParameters()
        }
    }
}
