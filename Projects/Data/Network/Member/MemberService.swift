import Combine
import Domain

final class MemberService: MemberRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }

    func edit(_ req: EditMemberReq) -> APIResult<BaseVoid> {
        runner.deepDive(MemberEndpoint.edit(req), res: BaseVoid.self)
    }
    
    func login(_ req: LoginMemberReq) -> APIResult<Base<Token>> {
        runner.deepDive(MemberEndpoint.login(req), res: Base<Token>.self)
    }
    
    func refresh(token: String) -> APIResult<Base<String>> {
        runner.deepDive(MemberEndpoint.refresh(token: token), res: Base<String>.self)
    }
    
    func register(_ req: RegisterMemberReq) -> APIResult<Base<Token>> {
        runner.deepDive(MemberEndpoint.register(req), res: Base<Token>.self)
    }
    
    func remove() -> APIResult<BaseVoid> {
        runner.deepDive(MemberEndpoint.remove, res: BaseVoid.self)
    }
    
    func myInfo() -> APIResult<Base<RetrieveMember>> {
        runner.deepDive(MemberEndpoint.myInfo, res: Base<RetrieveMember>.self)
    }
    
    func logout(_ req: LogoutReq) -> APIResult<BaseVoid> {
        runner.deepDive(MemberEndpoint.logout(req), res: BaseVoid.self)
    }
}
