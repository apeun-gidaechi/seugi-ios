import Moya
import Domain

enum MealEndpoint: SeugiEndpoint {
    case getAll(workspaceId: String)
    case getByDate(workspaceId: String, date: String)
    case reset(workspaceId: String)
}

extension MealEndpoint {
    
    static let provider = MoyaProvider<Self>(session: session)
    static let authProvider = MoyaProvider<Self>(session: authSession)
    
    var host: String {
        "meal"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getAll(let workspaceId):
                .get - "all" - ["workspaceId": workspaceId].toURLParameters()
        case .getByDate(let workspaceId, let date):
                .get - "" - ["workspaceId": workspaceId].toURLParameters()
        case .reset(let workspaceId):
                .post - "reset/\(workspaceId)" - .requestPlain
        }
    }
}
