import Swinject
import WaitingJoinFeatureInterface

public final class WaitingJoinAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any WaitingJoinFactory).self) { _ in
            WaitingJoinFactoryImpl()
        }
    }
}
