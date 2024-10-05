import Moya

enum TimetableEndpoint: SeugiEndpoint {
    case getWeekend(workspaceId: String)
    case getDay(workspaceId: String)
    case reset(workspaceId: String)
}

extension TimetableEndpoint {
    static let authProvider = MoyaProvider<Self>(session: authSession)
    static let provider = MoyaProvider<Self>(session: session)
    
    var host: String {
        "timetable"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getWeekend(let workspaceId):
                .get - "weekend" - ["workspaceId": workspaceId].toURLParameters()
        case .getDay(let workspaceId):
                .get - "day" - ["workspaceId": workspaceId].toURLParameters()
        case .reset(let workspaceId):
                .post - "reset" - ["workspaceId": workspaceId].toURLParameters()
        }
    }
}
