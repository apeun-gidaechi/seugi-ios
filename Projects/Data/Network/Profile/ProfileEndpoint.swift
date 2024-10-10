import Domain
import Moya

enum ProfileEndpoint {
    case me(workspaceId: String)
    case others(workspaceId: String, memberId: String)
    case patch(workspaceId: String, req: PatchProfileReq)
}

extension ProfileEndpoint: SeugiEndpoint {
    var host: String { "profile" }
    var route: Route {
        switch self {
        case .me(let workspaceId):
                .get("me")
                .task(["workspaceId": workspaceId].toURLParameters())
        case .others(let workspaceId, let memberId):
                .get("others")
                .task(["workspaceId": workspaceId, "memberId": memberId].toURLParameters())
        case .patch(let workspaceId, let req):
                .patch("\(workspaceId)")
                .task(req.toJSONParameters())
        }
    }
}
