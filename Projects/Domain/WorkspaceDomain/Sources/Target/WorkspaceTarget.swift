import Moya
import Foundation
import WorkspaceDomainInterface
import Secret

enum WorkspaceTarget {
    case getWorkspaces
    case getWorkspaceByCode(code: String)
    case joinWorkspace(_ req: JoinWorkspaceRequest)
}

extension WorkspaceTarget: TargetType {
    var baseURL: URL {
        URL(string: Secret.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getWorkspaces: 
            "workspace"
        case .getWorkspaceByCode(let code): 
            "workspace/\(code)"
        case .joinWorkspace:
            "workspace/join"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWorkspaces:
                .get
        case .getWorkspaceByCode:
                .get
        case .joinWorkspace:
                .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getWorkspaces:
                .requestPlain
        case .getWorkspaceByCode(let code):
                .requestPlain
        case .joinWorkspace(let req):
                .requestJSONEncodable(req)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
