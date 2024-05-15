import Moya
import Foundation
import BaseDomainInterface
import ChatDomainInterface
import Secret

enum PersonalChatTarget {
    case createPersonal(_ req: CreateChatRequest)
    case getPersonalChat(workspaceId: Int)
}

extension PersonalChatTarget: TargetType {
    var baseURL: URL {
        URL(string: Secret.baseURL)!
    }
    
    var path: String {
        switch self {
        case .createPersonal:
            "/chat/personal/create"
        case .getPersonalChat(let workspaceId):
            "/chat/personal/search/\(workspaceId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createPersonal: .post
        case .getPersonalChat: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createPersonal(let req): .requestJSONEncodable(req)
        case .getPersonalChat(let workspaceId): .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
