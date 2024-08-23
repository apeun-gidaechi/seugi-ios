import Swinject

public final class ChatDetailAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any ChatDetailFactory).self) { _ in
            ChatDetailFactoryImpl()
        }
        container.register(ChatDetailViewModel.self) { _ in
            ChatDetailViewModel()
        }
    }
}
