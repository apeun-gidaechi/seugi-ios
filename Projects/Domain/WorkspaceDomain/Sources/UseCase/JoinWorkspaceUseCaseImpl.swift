import WorkspaceDomainInterface

final class JoinWorkspaceUseCaseImpl: JoinWorkspaceUseCase {
    
    private let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func callAsFunction(_ req: JoinWorkspaceRequest) async throws {
        try await repository.joinWorkspace(req)
    }
}
