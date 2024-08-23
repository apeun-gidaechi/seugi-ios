import Swinject

public final class JoinWorkspaceAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any JoinWorkspaceFactory).self) { _ in
            JoinWorkspaceFactoryImpl()
        }
    }
}
