import Combine
public protocol MemberRepo {
    func edit(_ req: EditMemberReq) -> ObservableResult<BaseVoid>
    func login(_ req: LoginMemberReq) -> ObservableResult<Base<Token>>
    func refresh(token: String) -> ObservableResult<Base<String>>
    func register(_ req: RegisterMemberReq) -> ObservableResult<Base<Token>>
    func remove() -> ObservableResult<BaseVoid>
    func myInfo() -> ObservableResult<Base<RetrieveMember>>
}
