import Moya
import Domain

enum MemberEndpoint: SeugiEndpoint {
    case edit(_ req: EditMemberReq)
    case login(_ req: LoginMemberReq)
    case refresh(token: String)
    case register(_ req: RegisterMemberReq)
    case remove
    case myInfo
    case logout(_ req: LogoutReq)
}

extension MemberEndpoint {
    
    static let provider = MoyaProvider<MemberEndpoint>(session: session)
    static let authProvider = MoyaProvider<MemberEndpoint>(session: authSession)
    
    var host: String {
        "member"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .edit(let req):
                .patch - "edit" - req.toJSONParameters()
        case .login(let req):
                .post - "login" - req.toJSONParameters()
        case .refresh(let token):
                .get - "refresh" - ["token": "Bearer " + token].toURLParameters()
        case .register(let req):
                .post - "register" - req.toJSONParameters()
        case .remove:
                .delete - "remove" - .requestPlain
        case .myInfo:
                .patch - "myInfo" - .requestPlain
        case .logout(let req):
                .post - "logout" - req.toJSONParameters()
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .edit: .authorization
        case .login: .none
        case .refresh: .none
        case .register: .none
        case .remove: .authorization
        case .myInfo: .authorization
        case .logout: .authorization
        }
    }
}
