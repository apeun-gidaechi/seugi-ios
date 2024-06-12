import WorkspaceDomainInterface

final class GetWorkspaceByCodeUseCaseImpl: GetWorkspaceByCodeUseCase {
    
    private let repository: WorkspaceRepository
    
    init(repository: WorkspaceRepository) {
        self.repository = repository
    }
    
    func callAsFunction(code: String) async throws -> Workspace {
        try await repository.getWorkspaceByCode(code: code)
    }
}
