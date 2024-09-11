import Domain
import Combine

final class MemberService: Service<MemberEndpoint>, MemberRepo {
    
    func edit(_ req: EditMemberReq) -> APIResult<BaseVoid> {
        performRequest(.edit(req))
    }
    
    func login(_ req: LoginMemberReq) -> APIResult<Base<Token>> {
        performRequest(.login(req), res: Token.self)
    }
    
    func refresh(token: String) -> APIResult<Base<String>> {
        performRequest(.refresh(token: token), res: String.self)
    }
    
    func register(_ req: RegisterMemberReq) -> APIResult<Base<Token>> {
        performRequest(.register(req), res: Token.self)
    }
    
    func remove() -> APIResult<BaseVoid> {
        performRequest(.remove)
    }
    
    func myInfo() -> APIResult<Base<RetrieveMember>> {
        performRequest(.myInfo, res: RetrieveMember.self)
    }
}
