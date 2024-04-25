import Moya
import Foundation
import BaseDomainInterface
import ChatDomainInterface

enum ChatTarget {
    case createGroup(_ req: CreateGroupRequest)
    case getGroupChat(workspaceId: Int)
    case addJoined(_ req: AddJoinedRequest)
    case getJoined(roomId: Int)
    case outJoined(_ req: OutJoinedRequest)
}

extension ChatTarget: TargetType {
    var baseURL: URL {
        URL(string: baseUrl)!
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createGroup: .post
        case .getGroupChat: .get
        case .addJoined: .post
        case .getJoined: .get
        case .outJoined: .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createGroup(let req): .requestJSONEncodable(req)
        case .getGroupChat(let workspaceId): .requestPlain
        case .addJoined(let req): .requestJSONEncodable(req)
        case .getJoined(let roomId): .requestPlain
        case .outJoined(let req): .requestJSONEncodable(req)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
