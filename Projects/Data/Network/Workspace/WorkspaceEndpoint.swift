import Moya

public enum WorkspaceEndpoint: SeugiEndpoint {
    case getWorkspaces
    case getWorkspaceCode(workspaceId: String)
    case getWorkspace(code: String)
    case joinWorkspace(_ req: JoinWorkspaceReq)
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
                .get - "\(code)" - .requestPlain
        case .joinWorkspace(let req):
                .post - "join" - req.toJSONParameters()
        }
    }
}
