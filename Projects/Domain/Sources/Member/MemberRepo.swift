import Combine
public protocol MemberRepo {
    func edit(_ req: EditMemberReq) -> APIResult<BaseVoid>
    func login(_ req: LoginMemberReq) -> APIResult<Base<Token>>
    func oauth2(code: String, provider: OAuth2Provider) -> APIResult<Base<Token>>
    func oauth2Complete(_ req: OAuth2MemberReq) -> APIResult<BaseVoid>
    func refresh(token: String) -> APIResult<Base<String>>
    func register(_ req: RegisterMemberReq) -> APIResult<Base<Token>>
    func remove() -> APIResult<BaseVoid>
    func myInfo() -> APIResult<Base<RetrieveMember>>
}
