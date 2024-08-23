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
            // Feature
            ChatDetailAssembly(),
            Feature.ChatAssembly(),
            CreateGroupChatAssembly(),
            HomeAssembly(),
            JoinWorkspaceAssembly(),
            LaunchScreenAssembly(),
            MainAssembly(),
            OnboardingAssembly(),
            RootAssembly(),
            Feature.NotificationAssembly(),
            Feature.ProfileAssembly(),
            PostNotificationAssembly(),
            CreateWorkspaceAssembly(),
            SettingProfileAssembly(),
            WorkspaceDetailAssembly(),
            // Domain
            MemberAssembly(),
            Network.ChatAssembly(),
            WorkspaceAssembly(),
            EmailAssembly(),
            MessageAssembly(),
            Network.NotificationAssembly(),
            Network.ProfileAssembly(),
            FileAssembly(),
            // Core
            KeyValueStoreAssembly()
        ], container: container)
    }
}
