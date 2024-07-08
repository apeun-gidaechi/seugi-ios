import Swinject
import Domain

public final class MessageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MessageService.self) { _ in
            MessageService()
        }.inObjectScope(.container)
        container.register(MessageRepo.self) { resolver in
            resolver.resolve(MessageService.self)!
        }
        container.register(StompRepo.self) { resolver in
            resolver.resolve(MessageService.self)!
        }
        container.register(StompMessageRepo.self) { resolver in
            resolver.resolve(MessageService.self)!
        }
    }
}
