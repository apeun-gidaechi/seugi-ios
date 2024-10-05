import Domain
import Swinject

public final class ChatAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ChatRepo.self) {
            ChatService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
