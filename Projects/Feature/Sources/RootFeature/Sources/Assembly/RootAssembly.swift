import Swinject

public final class RootAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any RootFactory).self) { _ in
            RootFactoryImpl()
        }
        container.register(RootViewModel.self) { _ in
            RootViewModel()
        }
    }
}
