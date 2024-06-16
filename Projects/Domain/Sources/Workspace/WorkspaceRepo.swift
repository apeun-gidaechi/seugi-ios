import SwiftUtil

public protocol WorkspaceRepo {
    func getWorkspaces() -> APIResult<Base<[Workspace]>>
    func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>>
    func getWorkspace(code: String) -> APIResult<Base<Workspace>>
    func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid>
}
