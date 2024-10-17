import Combine
import Domain

final class ProfileService: ProfileRepo {
    let runner: NetRunner

    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>> {
        runner.deepDive(ProfileEndpoint.me(workspaceId: workspaceId), res: Base<RetrieveProfile>.self)
    }
    
    func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>> {
        runner.deepDive(ProfileEndpoint.others(workspaceId: workspaceId, memberId: memberId), res: Base<RetrieveProfile>.self)
    }
    
    func patchProfile(workspaceId: String, _ req: PatchProfileReq) -> APIResult<BaseVoid> {
        runner.deepDive(ProfileEndpoint.patch(workspaceId: workspaceId, req: req), res: BaseVoid.self)
    }
}
