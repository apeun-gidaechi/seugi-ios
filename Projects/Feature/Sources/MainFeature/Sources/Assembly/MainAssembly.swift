import Swinject

public final class MainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any MainFactory).self) { _ in
            MainFactoryImpl()
        }
    }
}
