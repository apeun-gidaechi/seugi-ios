import Swinject
import CreateRoomFeatureInterface

public final class CreateRoomAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(CreateRoomViewModel.self) { _ in
            CreateRoomViewModel()
        }
        container.register((any CreateRoomFactory).self) { _ in
            CreateRoomFactoryImpl()
        }
    }
}
