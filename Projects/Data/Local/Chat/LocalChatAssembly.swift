import Swinject
import Domain

public final class LocalChatAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(LocalChatRepo.self) { _ in
            LocalChatService()
        }
    }
}
