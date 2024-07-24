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
}
