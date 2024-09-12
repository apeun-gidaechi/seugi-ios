import Moya
import Domain

enum ChatEndpoint: SeugiEndpoint {
    
    // MemberGroup
    case addMemberGroup(_ req: ChatMemberEventReq)
    case kickMemberGroup(_ req: ChatMemberEventReq)
    case tossMemberGroup(_ req: ChatMemberEventReq)
    
    // Group
    case createGroup(_ req: CreateGroupChatReq)
    case searchGroupByWord(workspaceId: String, word: String)
    case searchGroupById(roomId: String)
    case searchGroup(workspaceId: String)
    case leftGroup(roomId: String)
    
    // Personal
    case createPersonal(_ req: CreateGroupChatReq)
    case searchPersonalByWord(workspaceId: String, word: String)
    case searchPersonalById(roomId: String)
    case searchPersonal(workspaceId: String)
}

extension ChatEndpoint {
    
    static let provider = MoyaProvider<Self>(session: session)
    static let authProvider = MoyaProvider<Self>(session: authSession)
    
    var host: String {
        "chat"
    }
    
    var route: (Moya.Method, String, Moya.Task) {
        switch self {
        case .addMemberGroup(let req):
                .post - "group/member/add" - req.toJSONParameters()
        case .kickMemberGroup(let req):
                .patch - "group/member/kick" - req.toJSONParameters()
        case .tossMemberGroup(let req):
                .patch - "group/member/toss" - req.toJSONParameters()
        case .createGroup(let req):
                .post - "group/create" - req.toJSONParameters()
        case .searchGroupByWord(let workspaceId, let word):
                .get - "group/search" - ["workspaceId": workspaceId, "word": word].toURLParameters()
        case .searchGroupById(let roomId):
                .get - "group/search/room/\(roomId)" - .requestPlain
        case .searchGroup(let workspaceId):
                .get - "group/search/\(workspaceId)" - .requestPlain
        case .leftGroup(let roomId):
                .patch - "group/left/\(roomId)" - .requestPlain
        case .createPersonal(let req):
                .post - "personal/create" - req.toJSONParameters()
        case .searchPersonalByWord(let workspaceId, let word):
                .get - "personal/search" - ["workspaceId": workspaceId, "word": word].toURLParameters()
        case .searchPersonalById(let roomId):
                .get - "personal/search/room/\(roomId)" - .requestPlain
        case .searchPersonal(let workspaceId):
                .get - "personal/search/\(workspaceId)" - .requestPlain
        }
    }
}
