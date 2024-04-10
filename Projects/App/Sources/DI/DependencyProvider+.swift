import DIContainerInterface
import StartFeature
import Swinject

extension DependencyProvider {
    func register() {
        _ = Assembler([
            StartAssembly()
        ], container: container)
    }
}
