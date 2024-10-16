import DIContainer
import Domain
import Core
import Network
import Local
import Swinject

public extension DependencyProvider {
    func register() {
        _ = Assembler([
            // Network
            NetRunnerAssembly(),
            InterceptorAssembly(),
            
            MealAssembly(),
            TimetableAssembly(),
            ScheduleAssembly(),
            // Local
            LocalChatAssembly(),
            // Core
            KeyValueAssembly(),
            KeychainAssembly()
        ], container: container)
    }
}
