import DIContainer

import Domain

import Core
import Remote
import Local

import Swinject

public extension DependencyProvider {
    func register() {
        _ = Assembler([
            // Network
            NetRunnerAssembly(),
            InterceptorAssembly(),
            
            MemberAssembly(),
            ChatAssembly(),
            WorkspaceAssembly(),
            EmailAssembly(),
            MessageAssembly(),
            NotificationAssembly(),
            ProfileAssembly(),
            FileAssembly(),
            MealAssembly(),
            TimetableAssembly(),
            OAuthAssembly(),
            CatSeugiAssembly(),
            ScheduleAssembly(),
            // Local
            LocalChatAssembly(),
            // Core
            KeyValueAssembly(),
            KeychainAssembly()
        ], container: container)
    }
}
