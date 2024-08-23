import Swinject

public final class LaunchScreenAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any LaunchScreenFactory).self) { _ in
            LaunchScreenFactoryImpl()
        }
    }
}
