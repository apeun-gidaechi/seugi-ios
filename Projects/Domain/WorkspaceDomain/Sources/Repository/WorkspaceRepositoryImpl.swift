import WorkspaceDomainInterface

final class WorkspaceRepositoryImpl: WorkspaceRepository {
    
    private let dataSource: WorkspaceDataSource
    
    init(dataSource: WorkspaceDataSource) {
        self.dataSource = dataSource
    }
    
    func getWorkspaces() async throws -> [Workspace] {
        try await dataSource.getWorkspaces()
    }
    
    func getWorkspaceByCode(code: String) async throws -> Workspace {
        try await dataSource.getWorkspaceByCode(code: code)
    }
    
    func joinWorkspace(_ req: JoinWorkspaceRequest) async throws {
        try await dataSource.joinWorkspace(req)
    }
}
