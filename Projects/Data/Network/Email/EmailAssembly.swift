import Swinject
import Domain

public final class EmailAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(EmailRepo.self) { _ in
            EmailService()
        }
    }
}
