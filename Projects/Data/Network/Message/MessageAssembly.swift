import Swinject
import Domain

public final class MessageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MessageService.self) {
            MessageService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
        container.register(MessageRepo.self) { resolver in
            resolver.resolve(MessageService.self)!
        }.inObjectScope(.container)
        container.register(StompRepo.self) { resolver in
            resolver.resolve(MessageService.self)!
        }.inObjectScope(.container)
        container.register(StompMessageRepo.self) { resolver in
            resolver.resolve(MessageService.self)!
        }.inObjectScope(.container)
    }
}
