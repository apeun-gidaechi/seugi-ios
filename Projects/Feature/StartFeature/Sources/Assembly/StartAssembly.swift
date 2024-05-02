import StartFeatureInterface
import Swinject

public final class StartAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any StartFactory).self) { _ in
            StartFactoryImpl()
        }
        container.register(StartViewModel.self) { _ in
            StartViewModel()
        }
    }
}
