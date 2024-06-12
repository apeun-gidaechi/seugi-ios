import WorkspaceDomainInterface

final class GetWorkspacesUseCaseImpl: GetWorkspacesUseCase {
    
    private let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func callAsFunction() async throws -> [Workspace] {
        try await repository.getWorkspaces()
    }
}
