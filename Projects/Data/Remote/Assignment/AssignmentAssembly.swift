import Swinject
import Domain

public final class AssignmentAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AssignmentRepo.self) {
            AssignmentService(runner: $0.resolve(NetRunner.self)!)
        }
    }
}
