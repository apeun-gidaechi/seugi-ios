import Swinject

import Domain

public final class TimetableAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(TimetableRepo.self) { _ in
            TimetableService()
        }
    }
}
