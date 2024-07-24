import Domain

public final class FakeWorkspaceRepo: WorkspaceRepo {
    
    public init() {}
    public func getWorkspaces() -> APIResult<Base<[Workspace]>> {
        [Workspace.mock()].successBaseResult
    }
    
    public func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>> {
        "123456".successBaseResult
    }
    
    public func getWorkspace(code: String) -> APIResult<Base<Workspace>> {
        Workspace.mock().successBaseResult
    }
    
    public func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func getMembers(workspaceId: String) -> APIResult<Base<[RetrieveProfile]>> {
        return (0..<100).map { _ in RetrieveProfile.mock() }.successBaseResult
    }
    
    public func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func removeWorkspace(workspaceId: String) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func approveJoinWorkspace(workspaceId: String, approvalUserSer: [Int], role: WorkspaceRole) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> APIResult<Base<[Int]>> {
        [Int.randomIn10()].successBaseResult
    }
    
    public func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func getMyWaitList() -> APIResult<Base<[Workspace]>> {
        [Workspace.mock()].successBaseResult
    }
}
