import Domain
import Moya

enum TaskEndpoint {
    case getTasks(workspaceId: String)
    case getClassroomTasks
    case createTask(CreateTaskReq)
}

extension TaskEndpoint: SeugiEndpoint {
    var host: String { "task" }
    var route: Route {
        switch self {
        case .getTasks(let workspaceId):
                .get(workspaceId)
        case .getClassroomTasks:
                .get("classroom")
        case .createTask(let req):
                .post()
                .task(req.toJSONParameters())
        }
    }
}
