import Swinject
import CreateGroupChatFeatureInterface

public final class CreateGroupChatAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(CreateGroupChatViewModel.self) { _ in
            CreateGroupChatViewModel()
        }
        container.register((any CreateGroupChatFactory).self) { _ in
            CreateGroupChatFactoryImpl()
        }
    }
}
