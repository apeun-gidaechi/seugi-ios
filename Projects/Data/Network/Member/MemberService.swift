import Domain
import Combine
import SwiftUtil

final class MemberService: Service, MemberRepo {
    
    typealias Target = MemberEndpoint
    
    func edit(picture: String, name: String, birth: String) -> APIResult<BaseVoid> {
        request(.edit(.init(picture: picture, name: name, birth: birth)))
            .map { $0.toEntity() }
            .asResult()
    }
    
    func login(email: String, password: String) -> APIResult<Base<Token>> {
        request(.login(.init(email: email, password: password)), res: BaseRes<TokenRes>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func oauth2(code: String, provider: OAuth2Provider) -> APIResult<Base<Token>> {
        request(.oauth2(code: code, provider: provider), res: BaseRes<TokenRes>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func oauth2Complete(email: String, name: String) -> APIResult<BaseVoid> {
        request(.oauth2Complete(.init(email: email, name: name)))
            .map { $0.toEntity() }
            .asResult()
    }
    
    func refresh(token: String) -> APIResult<Base<String>> {
        request(.refresh(token: token), res: BaseRes<String>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func register(name: String, email: String, password: String, code: String) -> APIResult<Base<String>> {
        request(.register(.init(name: name, email: email, password: password, code: code)), res: BaseRes<String>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func remove() -> APIResult<BaseVoid> {
        request(.remove)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func myInfo() -> APIResult<Base<RetrieveMember>> {
        request(.myInfo, res: BaseRes<RetrieveMemberRes>.self)
            .map { $0.toEntity() }
            .asResult()
    }
}
