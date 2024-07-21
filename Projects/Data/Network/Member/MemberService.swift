import Domain
import Combine
import SwiftUtil

final class MemberService: Service<MemberEndpoint>, MemberRepo {
    
    func edit(picture: String, name: String, birth: String) -> APIResult<BaseVoid> {
        performRequest(.edit(.init(picture: picture, name: name, birth: birth)))
    }
    
    func login(email: String, password: String) -> APIResult<Base<Token>> {
        performRequest(.login(.init(email: email, password: password)), res: TokenRes.self)
    }
    
    func oauth2(code: String, provider: OAuth2Provider) -> APIResult<Base<Token>> {
        performRequest(.oauth2(code: code, provider: provider), res: TokenRes.self)
    }
    
    func oauth2Complete(email: String, name: String) -> APIResult<BaseVoid> {
        performRequest(.oauth2Complete(.init(email: email, name: name)))
    }
    
    func refresh(token: String) -> APIResult<Base<String>> {
        performRequest(.refresh(token: token), res: String.self)
    }
    
    func register(name: String, email: String, password: String, code: String) -> APIResult<Base<Token>> {
        performRequest(.register(.init(name: name, email: email, password: password, code: code)), res: TokenRes.self)
    }
    
    func remove() -> APIResult<BaseVoid> {
        performRequest(.remove)
    }
    
    func myInfo() -> APIResult<Base<RetrieveMember>> {
        performRequest(.myInfo, res: RetrieveMemberRes.self)
    }
}
