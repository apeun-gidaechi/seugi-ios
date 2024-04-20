import Swinject
import EmailVerificationFeatureInterface

public final class EmailVerificationAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any EmailVerificationFactory).self) { _ in
            EmailVerificationFactoryImpl()
        }
        container.register(EmailVerificationViewModel.self) { _ in
            EmailVerificationViewModel()
        }.inObjectScope(.container)
    }
}
