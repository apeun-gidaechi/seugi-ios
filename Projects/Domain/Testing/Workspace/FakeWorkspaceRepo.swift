import Domain

public final class FakeWorkspaceRepo: WorkspaceRepo {
    
    public init() {}
    public func getWorkspaces() -> ObservableResult<Base<[Workspace]>> {
        [Workspace.mock()].successBaseResult
    }
    
    public func getWorkspaceCode(workspaceId: String) -> ObservableResult<Base<String>> {
        "123456".successBaseResult
    }
    
    public func getWorkspace(code: String) -> ObservableResult<Base<WorkspaceInfo>> {
        WorkspaceInfo.mock().successBaseResult
    }
    
    public func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func getMembers(workspaceId: String) -> ObservableResult<Base<[RetrieveProfile]>> {
        (0..<100).map { _ in RetrieveProfile.mock() }.successBaseResult
    }
    
    public func getMembersChart(workspaceId: String) -> ObservableResult<Base<WorkspaceMembersChart>> {
        WorkspaceMembersChart.mock().successBaseResult
    }
    
    public func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func removeWorkspace(workspaceId: String) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func addWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func cancelWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> ObservableResult<Base<[RetrieveMember]>> {
        [.mock()].successBaseResult
    }
    
    public func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func getMyWaitList() -> ObservableResult<Base<[WorkspaceInfo]>> {
//        [WorkspaceInfo.mock()].successBaseResult
        [].successBaseResult // TODO: Add mock
    }
}
