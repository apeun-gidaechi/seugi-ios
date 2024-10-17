import Domain
import Swinject

public final class ScheduleAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(ScheduleRepo.self) {
            ScheduleService(runner: $0.resolve(NetRunner.self)!)
        }
        .inObjectScope(.container)
    }
}
