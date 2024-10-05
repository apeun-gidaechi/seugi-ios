import Domain

import Swinject

public final class ChatAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ChatRepo.self) { _ in
            ChatService()
        }
    }
}
