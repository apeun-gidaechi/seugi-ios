import Swinject

public final class PostNotificationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any PostNotificationFactory).self) { _ in
            PostNotificationFactoryImpl()
        }
    }
}
