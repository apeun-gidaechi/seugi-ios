import Domain
import Combine

final class MemberService: Service<MemberEndpoint>, MemberRepo {
    
    func edit(_ req: EditMemberReq) -> ObservableResult<BaseVoid> {
        performRequest(.edit(req))
    }
    
    func login(_ req: LoginMemberReq) -> ObservableResult<Base<Token>> {
        performRequest(.login(req), res: Token.self)
    }
    
    func refresh(token: String) -> ObservableResult<Base<String>> {
        performRequest(.refresh(token: token), res: String.self)
    }
    
    func register(_ req: RegisterMemberReq) -> ObservableResult<Base<Token>> {
        performRequest(.register(req), res: Token.self)
    }
    
    func remove() -> ObservableResult<BaseVoid> {
        performRequest(.remove)
    }
    
    func myInfo() -> ObservableResult<Base<RetrieveMember>> {
        performRequest(.myInfo, res: RetrieveMember.self)
    }
}
