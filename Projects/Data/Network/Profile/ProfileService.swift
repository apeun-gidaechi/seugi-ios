import Domain
import Combine

final class ProfileService: Service<ProfileEndpoint>, ProfileRepo {
    func me(workspaceId: String) -> ObservableResult<Base<RetrieveProfile>> {
        performRequest(.me(workspaceId: workspaceId), res: RetrieveProfile.self)
    }
    
    func others(workspaceId: String, memberId: String) -> ObservableResult<Base<RetrieveProfile>> {
        performRequest(.others(workspaceId: workspaceId, memberId: memberId), res: RetrieveProfile.self)
    }
    
    func patchProfile(workspaceId: String, _ req: PatchProfileReq) -> ObservableResult<BaseVoid> {
        performRequest(.patch(workspaceId: workspaceId, req: req))
    }
}
