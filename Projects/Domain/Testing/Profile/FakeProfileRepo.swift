import Domain

public final class FakeProfileRepo: ProfileRepo {
    
    public init() {}
    public func patchProfile(workspaceId: String, _ req: Domain.PatchProfileReq) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>> {
        RetrieveProfile.mock().successBaseResult
    }
    
    public func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>> {
        RetrieveProfile.mock().successBaseResult
    }
}
