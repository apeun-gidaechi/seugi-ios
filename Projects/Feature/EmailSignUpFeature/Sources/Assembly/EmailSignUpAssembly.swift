import Swinject
import EmailSignUpFeatureInterface

public final class EmailSignUpAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any EmailSignUpFactory).self) { _ in
            EmailSignUpFactoryImpl()
        }
        container.register(EmailSignUpViewModel.self) { _ in
            EmailSignUpViewModel()
        }.inObjectScope(.container)
    }
}
