import Swinject

public final class ChatAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any ChatFactory).self) { _ in
            ChatFactoryImpl()
        }
        container.register(ChatViewModel.self) { _ in
            ChatViewModel()
        }
    }
}
