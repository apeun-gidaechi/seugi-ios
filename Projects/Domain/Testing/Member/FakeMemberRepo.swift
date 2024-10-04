import Domain
import Combine

public final class FakeMemberRepo: MemberRepo {
    
    public init() {}
    public func edit(_ req: EditMemberReq) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func login(_ req: LoginMemberReq) -> APIResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func refresh(token: String) -> APIResult<Base<String>> {
        "token".successBaseResult
    }
    
    public func register(_ req: RegisterMemberReq) -> APIResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func remove() -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func myInfo() -> APIResult<Base<RetrieveMember>> {
        RetrieveMember.mock().successBaseResult
    }
    
    public func logout(_ req: LogoutReq) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
}
