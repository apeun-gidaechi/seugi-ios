import Swinject
import CreateWorkspaceFeatureInterface

public final class CreateWorkspaceAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any CreateWorkspaceFactory).self) { _ in
            CreateWorkspaceFactoryImpl()
        }
    }
}
