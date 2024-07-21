import Domain
import Combine

public final class FakeMemberRepo: MemberRepo {
    public func edit(picture: String, name: String, birth: String) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func login(email: String, password: String) -> APIResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func oauth2(code: String, provider: OAuth2Provider) -> APIResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func oauth2Complete(email: String, name: String) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func refresh(token: String) -> APIResult<Base<String>> {
        "token".successBaseResult
    }
    
    public func register(name: String, email: String, password: String, code: String) -> APIResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func remove() -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func myInfo() -> APIResult<Base<RetrieveMember>> {
        RetrieveMember.mock().successBaseResult
    }
}
