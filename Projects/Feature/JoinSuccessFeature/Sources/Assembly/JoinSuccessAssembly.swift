import Swinject
import JoinSuccessFeatureInterface

public final class JoinSuccessAssembly: Assembly {
    public func assemble(container: Container) {
        container.register((any JoinSuccessFactory).self) { _ in
            JoinSuccessFactoryImpl()
        }
    }
}
