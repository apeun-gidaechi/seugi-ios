import Swinject
import UpdateNotificationFeatureInterface

public final class UpdateNotificationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any UpdateNotificationFactory).self) { _ in
            UpdateNotificationFactoryImpl()
        }
    }
}
