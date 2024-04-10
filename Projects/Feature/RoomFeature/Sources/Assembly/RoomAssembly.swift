import Swinject
import RoomFeatureInterface

public final class RoomAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any RoomFactory).self) { _ in
            RoomFactoryImpl()
        }
    }
}
