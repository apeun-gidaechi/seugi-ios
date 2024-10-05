import Domain

import Swinject

public final class MealAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MealRepo.self) {
            MealService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
