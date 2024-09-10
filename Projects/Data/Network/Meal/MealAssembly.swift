import Swinject
import Domain

public final class MealAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MealRepo.self) { _ in
            MealService()
        }
    }
}
