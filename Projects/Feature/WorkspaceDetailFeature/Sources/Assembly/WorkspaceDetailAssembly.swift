import Swinject
import WorkspaceDetailFeatureInterface

public final class WorkspaceDetailAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any WorkspaceDetailFactory).self) { _ in
            WorkspaceDetailFactoryImpl()
        }
    }
}
