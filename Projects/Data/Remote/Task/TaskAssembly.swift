import Swinject
import Domain

public final class TaskAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TaskRepo.self) {
            TaskService(runner: $0.resolve(NetRunner.self)!)
        }
    }
}
