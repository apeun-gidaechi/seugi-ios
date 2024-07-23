import Swinject
import CreateNotificationFeatureInterface

public final class CreateNotificationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any CreateNotificationFactory).self) { _ in
            CreateNotificationFactoryImpl()
        }
    }
}
