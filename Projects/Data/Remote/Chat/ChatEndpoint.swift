import Domain
import Moya

enum ChatEndpoint {
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

extension ChatEndpoint: SeugiEndpoint {
    var host: String { "chat" }
    var route: Route {
        switch self {
        case .addMemberGroup(let req):
                .post("group/member/add")
                .task(req.toJSONParameters())
        case .kickMemberGroup(let req):
                .patch("group/member/kick")
                .task(req.toJSONParameters())
        case .tossMemberGroup(let req):
                .patch("group/member/toss")
                .task(req.toJSONParameters())
        case .createGroup(let req):
                .post("group/create")
                .task(req.toJSONParameters())
        case .searchGroupByWord(let workspaceId, let word):
                .get("group/search")
                .task(["workspaceId": workspaceId, "word": word].toURLParameters())
        case .searchGroupById(let roomId):
                .get("group/search/room/\(roomId)")
        case .searchGroup(let workspaceId):
                .get("group/search/\(workspaceId)")
        case .leftGroup(let roomId):
                .patch("group/left/\(roomId)")
        case .createPersonal(let req):
                .post("personal/create")
                .task(req.toJSONParameters())
        case .searchPersonalByWord(let workspaceId, let word):
                .get("personal/search")
                .task(["workspaceId": workspaceId, "word": word].toURLParameters())
        case .searchPersonalById(let roomId):
                .get("personal/search/room/\(roomId)")
        case .searchPersonal(let workspaceId):
                .get("personal/search/\(workspaceId)")
        }
    }
}
