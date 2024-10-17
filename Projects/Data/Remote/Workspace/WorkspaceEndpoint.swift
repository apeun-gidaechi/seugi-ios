import Domain
import Moya

enum WorkspaceEndpoint {
    case getWorkspaces
    case getWorkspaceCode(workspaceId: String)
    case getWorkspace(code: String)
    case joinWorkspace(_ req: JoinWorkspaceReq)
    case getMembers(workspaceId: String)
    case getMembersChart(workspaceId: String)
    case createWorkspace(CreateWorkspaceReq)
    case removeWorkspace(workspaceId: String)
    case addWorkspace(WaitSetWorkspaceMemberReq)
    case cancelWorkspace(WaitSetWorkspaceMemberReq)
    case getWaitList(workspaceId: String, workspaceRole: WorkspaceRole)
    case updateWorkspace(UpdateWorkspaceReq)
    case getMyWaitList
}

extension WorkspaceEndpoint: SeugiEndpoint {
    var host: String { "workspace" }
    var route: Route {
        switch self {
        case .getWorkspaces:
                .get()
        case .getWorkspaceCode(let workspaceId):
                .get("code/\(workspaceId)")
        case .getWorkspace(let code):
                .get("search/\(code)")
        case .joinWorkspace(let req):
                .post("join")
                .task(req.toJSONParameters())
        case .getMembers(let workspaceId):
                .get("members")
                .task(["workspaceId": workspaceId].toURLParameters())
        case .getMembersChart(let workspaceId):
                .get("members/chart")
                .task(["workspaceId": workspaceId].toURLParameters())
        case .createWorkspace(let req):
                .post()
                .task(req.toJSONParameters())
        case .removeWorkspace(let workspaceId):
                .delete("\(workspaceId)")
        case .addWorkspace(let req):
                .patch("add")
                .task(req.toJSONParameters())
        case .cancelWorkspace(let req):
                .delete("cancel")
                .task(req.toJSONParameters())
        case .getWaitList(let workspaceId, let workspaceRole):
                .get("wait-list")
                .task(["workspaceId": workspaceId, "role": workspaceRole.rawValue].toURLParameters())
        case .updateWorkspace(let req):
                .patch()
                .task(req.toJSONParameters())
        case .getMyWaitList:
                .get("my/wait-list")
        }
    }
}
