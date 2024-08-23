import Swinject

public final class ProfileAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any ProfileFactory).self) { _ in
            ProfileFactoryImpl()
        }
    }
}
