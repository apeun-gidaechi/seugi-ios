import Swinject
import Domain

public final class NoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NoticeRepo.self) { _ in
            NoticeService()
        }
    }
}
