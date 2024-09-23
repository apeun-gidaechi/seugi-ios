import Domain
import Combine

public final class FakeMemberRepo: MemberRepo {
    
    public init() {}
    public func edit(_ req: EditMemberReq) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func login(_ req: LoginMemberReq) -> ObservableResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func refresh(token: String) -> ObservableResult<Base<String>> {
        "token".successBaseResult
    }
    
    public func register(_ req: RegisterMemberReq) -> ObservableResult<Base<Token>> {
        Token.mock().successBaseResult
    }
    
    public func remove() -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func myInfo() -> ObservableResult<Base<RetrieveMember>> {
        RetrieveMember.mock().successBaseResult
    }
    
    public func logout(_ req: LogoutReq) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
}
