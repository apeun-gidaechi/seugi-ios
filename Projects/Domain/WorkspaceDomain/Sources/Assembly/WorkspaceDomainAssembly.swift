import Swinject
import WorkspaceDomainInterface

public struct WorkspaceDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        
        // MARK: - UseCases
        container.register(GetWorkspacesUseCase.self) {
            GetWorkspacesUseCaseImpl(repository: $0.resolve(WorkspaceRepository.self)!)
        }
        container.register(GetWorkspaceByCodeUseCase.self) {
            GetWorkspaceByCodeUseCaseImpl(repository: $0.resolve(WorkspaceRepository.self)!)
        }
        container.register(JoinWorkspaceUseCase.self) {
            JoinWorkspaceUseCaseImpl(repository: $0.resolve(WorkspaceRepository.self)!)
        }
        
        // MARK: - Repository
        container.register(WorkspaceRepository.self) {
            WorkspaceRepositoryImpl(dataSource: $0.resolve(WorkspaceDataSource.self)!)
        }.inObjectScope(.container)
        
        // MARK: - DataSource
        container.register(WorkspaceDataSource.self) { _ in
            WorkspaceDataSourceImpl()
        }.inObjectScope(.container)
        
    }
}
