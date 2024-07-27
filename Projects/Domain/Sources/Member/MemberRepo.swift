import Combine
public protocol MemberRepo {
    func edit(picture: String, name: String, birth: String) -> APIResult<BaseVoid>
    func login(email: String, password: String) -> APIResult<Base<Token>>
    func oauth2(code: String, provider: OAuth2Provider) -> APIResult<Base<Token>>
    func oauth2Complete(email: String, name: String) -> APIResult<BaseVoid>
    func refresh(token: String) -> APIResult<Base<String>>
    func register(name: String, email: String, password: String, code: String) -> APIResult<Base<Token>>
    func remove() -> APIResult<BaseVoid>
    func myInfo() -> APIResult<Base<RetrieveMember>>
}
