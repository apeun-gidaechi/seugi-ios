import Swinject

public final class NotificationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any NotificationFactory).self) { _ in
            NotificationFactoryImpl()
        }
        container.register(NotificationViewModel.self) { _ in
            NotificationViewModel()
        }
    }
}
