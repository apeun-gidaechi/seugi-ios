import Swinject

import Domain

public final class TimetableAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(TimetableRepo.self) {
            TimetableService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
