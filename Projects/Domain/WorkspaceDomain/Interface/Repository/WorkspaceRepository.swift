public protocol WorkspaceRepository {
    func getWorkspaces() async throws -> [Workspace]
    func getWorkspaceByCode(code: String) async throws -> Workspace
    func joinWorkspace(_ req: JoinWorkspaceRequest) async throws
}
