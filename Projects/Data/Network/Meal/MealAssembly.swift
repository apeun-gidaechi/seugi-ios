import Domain

import Swinject

public final class MealAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MealRepo.self) { _ in
            MealService()
        }
    }
}
