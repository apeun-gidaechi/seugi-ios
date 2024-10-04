public protocol MemberRepo {
    func edit(_ req: EditMemberReq) -> APIResult<BaseVoid>
    func login(_ req: LoginMemberReq) -> APIResult<Base<Token>>
    func refresh(token: String) -> APIResult<Base<String>>
    func register(_ req: RegisterMemberReq) -> APIResult<Base<Token>>
    func remove() -> APIResult<BaseVoid>
    func myInfo() -> APIResult<Base<RetrieveMember>>
    func logout(_ req: LogoutReq) -> APIResult<BaseVoid>
}
