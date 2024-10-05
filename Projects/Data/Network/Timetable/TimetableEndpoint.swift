import Moya

enum TimetableEndpoint {
    case getWeekend(workspaceId: String)
    case getDay(workspaceId: String)
    case reset(workspaceId: String)
}

extension TimetableEndpoint: SeugiEndpoint {
    var host: String { "timetable" }
    var route: Route {
        switch self {
        case .getWeekend(let workspaceId):
            return .get("weekend")
                .task(["workspaceId": workspaceId].toURLParameters())
        case .getDay(let workspaceId):
            return .get("day")
                .task(["workspaceId": workspaceId].toURLParameters())
        case .reset(let workspaceId):
            return .post("reset")
                .task(["workspaceId": workspaceId].toURLParameters())
        }
    }
}
