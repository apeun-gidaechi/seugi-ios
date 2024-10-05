import Domain

import Swinject

public final class WorkspaceAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(WorkspaceRepo.self) { _ in
            WorkspaceService()
        }
    }
}
