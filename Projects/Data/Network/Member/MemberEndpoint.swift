import Domain
import Moya

enum MemberEndpoint {
    case edit(_ req: EditMemberReq)
    case login(_ req: LoginMemberReq)
    case refresh(token: String)
    case register(_ req: RegisterMemberReq)
    case remove
    case myInfo
    case logout(_ req: LogoutReq)
}

extension MemberEndpoint: SeugiEndpoint {
    var host: String { "member" }
    var route: Route {
        switch self {
        case .edit(let req):
            return .patch("edit")
                .task(req.toJSONParameters())
        case .login(let req):
            return .post("login")
                .task(req.toJSONParameters())
        case .refresh(let token):
            return .get("refresh")
                .task(["token": "Bearer " + token].toURLParameters())
        case .register(let req):
            return .post("register")
                .task(req.toJSONParameters())
        case .remove:
            return .delete("remove")
        case .myInfo:
            return .patch("myInfo")
        case .logout(let req):
            return .post("logout")
                .task(req.toJSONParameters())
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .login, .refresh, .register:
            return .none
        default:
            return .refresh
        }
    }
}
