import Swinject
import Domain

public final class NotificationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NotificationRepo.self) { _ in
            NotificationService()
        }
    }
}
