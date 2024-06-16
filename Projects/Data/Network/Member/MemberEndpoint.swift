import Moya
import Domain

enum MemberEndpoint: SeugiEndpoint {
    case edit(_ req: EditMemberReq)
    case login(_ req: LoginMemberReq)
    case oauth2(code: String, provider: OAuth2Provider)
    case oauth2Complete(_ req: OAuth2MemberReq)
    case refresh(token: String)
    case register(_ req: RegisterMemberReq)
    case remove
    case myInfo
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
        case .oauth2(let code, let provider):
                .post - "oauth2" - ["code": code, "provider": provider.rawValue].toURLParameters()
        case .oauth2Complete(let req):
                .post - "oauth2/complete" - .requestJSONEncodable(req)
        case .refresh(let token):
                .get - "refresh" - ["token": "Bearer " + token].toURLParameters()
        case .register(let req):
                .post - "register" - req.toJSONParameters()
        case .remove:
                .delete - "remove" - .requestPlain
        case .myInfo:
                .patch - "myInfo" - .requestPlain
        }
    }
    
    var authorization: Authorization {
        switch self {
        case .edit: .authorization
        case .login: .none
        case .oauth2: .none
        case .oauth2Complete: .none
        case .refresh: .none
        case .register: .none
        case .remove: .authorization
        case .myInfo: .authorization
        }
    }
}
