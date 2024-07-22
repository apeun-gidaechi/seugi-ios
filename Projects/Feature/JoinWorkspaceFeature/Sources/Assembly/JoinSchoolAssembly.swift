import Swinject
import JoinWorkspaceFeatureInterface

public final class JoinSchoolAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any JoinSchoolFactory).self) { _ in
            JoinSchoolFactoryImpl()
        }
    }
}
