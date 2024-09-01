import DIContainer

// Feature
import Feature

// Domain
import Domain

// Data
import Core
import Network
import Local

// SPM
import Swinject

public extension DependencyProvider {
    func register() {
        _ = Assembler([
            // Network
            MemberAssembly(),
            ChatAssembly(),
            WorkspaceAssembly(),
            EmailAssembly(),
            MessageAssembly(),
            NotificationAssembly(),
            ProfileAssembly(),
            FileAssembly(),
            // Local
            LocalChatAssembly(),
            // Core
            KeyValueStoreAssembly()
        ], container: container)
    }
}
