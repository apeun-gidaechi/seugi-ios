import Swinject
import OnboardingFeatureInterface

public final class OnboardingAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any OnboardingFactory).self) { _ in
            OnboardingFactoryImpl()
        }
    }
}
