import Swinject
import OAuthSignUpFeatureInterface

public final class OAuthSignUpAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any OAuthSignUpFactory).self) { _ in
            OAuthSignUpFactoryImpl()
        }
    }
}
