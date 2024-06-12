import Moya
import Foundation
import BaseDomainInterface
import ChatDomainInterface
import Secret

enum PersonalChatTarget {
    case createPersonal(_ req: CreateChatRequest)
    case getPersonalChat(workspaceId: Int)
    case searchPersonalChat(workspaceId: Int, word: String)
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
        case .searchPersonalChat(let workspaceId, let word):
            "/chat/personal/search?workspace=\(workspaceId)&word=\(word)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createPersonal: .post
        case .getPersonalChat: .get
        case .searchPersonalChat: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createPersonal(let req): .requestJSONEncodable(req)
        case .getPersonalChat: .requestPlain
        case .searchPersonalChat: .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
