import Swinject
import JoinSchoolFeatureInterface

public final class JoinSchoolAssembly: Assembly {
    public func assemble(container: Container) {
        container.register((any JoinSchoolFactory).self) { _ in
            JoinSchoolFactoryImpl()
        }
    }
}
