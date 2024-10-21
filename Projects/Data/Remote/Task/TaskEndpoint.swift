import Domain
import Moya

enum TaskEndpoint {
    case getTasks(workspaceId: String)
    case createTask(CreateTaskReq)
}

extension TaskEndpoint: SeugiEndpoint {
    var host: String { "task" }
    var route: Route {
        switch self {
        case .getTasks(let workspaceId):
                .get(workspaceId)
        case .createTask(let req):
                .post()
                .task(req.toJSONParameters())
        }
    }
}
