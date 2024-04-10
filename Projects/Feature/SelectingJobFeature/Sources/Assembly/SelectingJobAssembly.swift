import Swinject
import SelectingJobFeatureInterface

public final class SelectingJobAssembly: Assembly {
    public func assemble(container: Container) {
        container.register((any SelectingJobFactory).self) { _ in
            SelectingJobFactoryImpl()
        }
    }
}
