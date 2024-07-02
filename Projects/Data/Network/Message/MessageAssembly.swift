import Swinject
import Domain

public final class MessageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MessageRepo.self) { _ in
            MessageService()
        }
    }
}
