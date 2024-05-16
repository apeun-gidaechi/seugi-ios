import Foundation
import Moya
import BaseDomainInterface
import AuthDomainInterface
import Secret

enum OAuthTarget {
    case oauthSignIn(code: String, registrationId: String)
}

extension OAuthTarget: TargetType {
    var baseURL: URL {
        URL(string: Secret.baseURL)!
    }
    
    var path: String {
        switch self {
        case .oauthSignIn: "/member/oauth2"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oauthSignIn: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .oauthSignIn(let code, let registrationId): .requestParameters(parameters: ["code": code, "provider": registrationId], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}
