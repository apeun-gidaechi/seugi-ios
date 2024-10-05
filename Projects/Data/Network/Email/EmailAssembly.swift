import Swinject
import Domain

public final class EmailAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(EmailRepo.self) {
            EmailService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
