import Domain

import Swinject

public final class WorkspaceAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(WorkspaceRepo.self) {
            WorkspaceService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
