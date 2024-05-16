import Moya
import Foundation
import BaseDomainInterface
import ChatDomainInterface
import Secret

enum GroupChatTarget {
    case createGroup(_ req: CreateChatRequest)
    case getGroupChat(workspaceId: Int)
    case addJoined(_ req: AddJoinedRequest)
    case getJoined(roomId: Int)
    case outJoined(_ req: OutJoinedRequest)
    case searchGroupChat(workspaceId: Int, word: String)
}

extension GroupChatTarget: TargetType {
    var baseURL: URL {
        URL(string: Secret.baseURL)!
    }
    
    var path: String {
        switch self {
        case .createGroup:
            "/chat/group/create"
        case .getGroupChat(let workspaceId):
            "/chat/group/search/\(workspaceId)"
        case .addJoined:
            "/joined/add"
        case .getJoined(let roomId):
            "/joined/\(roomId)"
        case .outJoined:
            "/joined/out"
        case .searchGroupChat(let workspaceId, let word):
            "/chat/group/search?workspace=\(workspaceId)&word=\(word)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createGroup: .post
        case .getGroupChat: .get
        case .addJoined: .post
        case .getJoined: .get
        case .outJoined: .patch
        case .searchGroupChat: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createGroup(let req): .requestJSONEncodable(req)
        case .getGroupChat: .requestPlain
        case .addJoined(let req): .requestJSONEncodable(req)
        case .getJoined: .requestPlain
        case .outJoined(let req): .requestJSONEncodable(req)
        case .searchGroupChat: .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
