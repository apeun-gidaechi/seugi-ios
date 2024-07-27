import SwiftUtil

public protocol WorkspaceRepo {
    func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid>
    func getWorkspaces() -> APIResult<Base<[Workspace]>>
    func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>>
    func getWorkspace(code: String) -> APIResult<Base<WorkspaceInfo>>
    func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid>
    func getMembers(workspaceId: String) -> APIResult<Base<[RetrieveProfile]>>
    func getMembersChart(workspaceId: String) -> APIResult<Base<WorkspaceMembersChart>>
    func removeWorkspace(workspaceId: String) -> APIResult<BaseVoid>
    func approveJoinWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> APIResult<BaseVoid>
    func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> APIResult<Base<[RetrieveMember]>>
    func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid>
    func getMyWaitList() -> APIResult<Base<[WorkspaceInfo]>>
}
