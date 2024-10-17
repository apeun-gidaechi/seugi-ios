import DIContainer
import Remote
import Domain
import Core
import Local
import Swinject

extension DependencyProvider {
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
