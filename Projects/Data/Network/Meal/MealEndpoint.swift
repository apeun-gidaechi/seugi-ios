import Domain
import Moya

enum MealEndpoint {
    case getAll(workspaceId: String)
    case getByDate(workspaceId: String, date: String)
    case reset(workspaceId: String)
}

extension MealEndpoint: SeugiEndpoint {
    var host: String { "meal" }
    var route: Route {
        switch self {
        case .getAll(let workspaceId):
                .get("all")
                .task(["workspaceId": workspaceId].toURLParameters())
        case .getByDate(let workspaceId, let date):
                .get()
                .task(["workspaceId": workspaceId, "date": date].toURLParameters())
        case .reset(let workspaceId):
                .post("reset/\(workspaceId)")
        }
    }
}
