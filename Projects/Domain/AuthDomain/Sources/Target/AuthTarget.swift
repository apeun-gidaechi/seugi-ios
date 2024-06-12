import Foundation
import Moya
import BaseDomainInterface
import AuthDomainInterface
import Secret

enum AuthTarget {
    case signIn(_ req: SignInRequest)
    case signUp(_ req: SignUpRequest)
    case sendEmailCode(email: String)
    case verifyEmailCode(code: String)
}

extension AuthTarget: TargetType {
    var baseURL: URL {
        URL(string: Secret.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signIn: "/member/login"
        case .signUp: "/member/register"
        case .sendEmailCode(let email): "/email/send"
        case .verifyEmailCode(let code): "/email/verify"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn: .post
        case .signUp: .post
        case .sendEmailCode: .get
        case .verifyEmailCode: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signIn(let req): .requestJSONEncodable(req)
        case .signUp(let req): .requestJSONEncodable(req)
        case .sendEmailCode(let email): .requestParameters(parameters: ["email": email], encoding: URLEncoding.default)
        case .verifyEmailCode(let code): .requestParameters(parameters: ["code": code], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        nil
    }
}
