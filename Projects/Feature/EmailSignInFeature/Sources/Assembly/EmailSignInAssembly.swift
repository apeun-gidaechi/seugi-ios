import EmailSignInFeatureInterface
import Swinject

public final class EmailSignInAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any EmailSignInFactory).self) { _ in
            EmailSignInFactoryImpl()
        }
        container.register(EmailSignInViewModel.self) { _ in
            EmailSignInViewModel()
        }.inObjectScope(.container)
    }
}
