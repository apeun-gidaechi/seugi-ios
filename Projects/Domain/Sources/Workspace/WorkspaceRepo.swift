public protocol WorkspaceRepo {
    func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> ObservableResult<BaseVoid>
    func getWorkspaces() -> ObservableResult<Base<[Workspace]>>
    func getWorkspaceCode(workspaceId: String) -> ObservableResult<Base<String>>
    func getWorkspace(code: String) -> ObservableResult<Base<WorkspaceInfo>>
    func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> ObservableResult<BaseVoid>
    func getMembers(workspaceId: String) -> ObservableResult<Base<[RetrieveProfile]>>
    func getMembersChart(workspaceId: String) -> ObservableResult<Base<WorkspaceMembersChart>>
    func removeWorkspace(workspaceId: String) -> ObservableResult<BaseVoid>
    func addWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> ObservableResult<BaseVoid>
    func cancelWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> ObservableResult<BaseVoid>
    func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> ObservableResult<Base<[RetrieveMember]>>
    func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> ObservableResult<BaseVoid>
    func getMyWaitList() -> ObservableResult<Base<[WorkspaceInfo]>>
}
