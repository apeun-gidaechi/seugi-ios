import Domain

import Moya

public enum WorkspaceEndpoint: SeugiEndpoint {
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

public extension WorkspaceEndpoint {
    static let provider = MoyaProvider<WorkspaceEndpoint>(session: session)
    static let authProvider = MoyaProvider<WorkspaceEndpoint>(session: authSession)
    
    var host: String {
        "workspace"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .getWorkspaces:
                .get - "" - .requestPlain
        case .getWorkspaceCode(let workspaceId):
                .get - "code/\(workspaceId)" - .requestPlain
        case .getWorkspace(let code):
                .get - "search/\(code)" - .requestPlain
        case .joinWorkspace(let req):
                .post - "join" - req.toJSONParameters()
        case .getMembers(let workspaceId):
                .get - "members" - ["workspaceId": workspaceId].toURLParameters()
        case .getMembersChart(let workspaceId):
                .get - "members/chart" - ["workspaceId": workspaceId].toURLParameters()
        case .createWorkspace(let req):
                .post - "" - req.toJSONParameters()
        case .removeWorkspace(let workspaceId):
                .delete - "\(workspaceId)" - .requestPlain
        case .addWorkspace(let req):
                .patch - "add" - req.toJSONParameters()
        case .cancelWorkspace(let req):
                .delete - "cancel" - req.toJSONParameters()
        case .getWaitList(let workspaceId, let workspaceRole):
                .get - "wait-list" - ["workspaceId": workspaceId, "role": workspaceRole.rawValue].toURLParameters()
        case .updateWorkspace(let req):
                .patch - "" - req.toJSONParameters()
        case .getMyWaitList:
                .get - "my/wait-list" - .requestPlain
        }
    }
}
