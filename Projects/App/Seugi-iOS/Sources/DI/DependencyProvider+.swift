import DIContainer

// Feature
import ChatDetailFeature
import ChatFeature
import CreateGroupChatFeature
import HomeFeature
import JoinWorkspaceFeature
import LaunchScreenFeature
import MainFeature
import OnboardingFeature
import RootFeature
import NotificationFeature
import ProfileFeature

// Domain
import Domain

// Data
import Core
import Network
import Local

// SPM
import Swinject

extension DependencyProvider {
    func register() {
        _ = Assembler([
            // Feature
            ChatDetailAssembly(),
            ChatFeature.ChatAssembly(),
            CreateGroupChatAssembly(),
            HomeAssembly(),
            JoinWorkspaceAssembly(),
            LaunchScreenAssembly(),
            MainAssembly(),
            OnboardingAssembly(),
            RootAssembly(),
            NotificationAssembly(),
            ProfileFeature.ProfileAssembly(),
            // Domain
            MemberAssembly(),
            Network.ChatAssembly(),
            WorkspaceAssembly(),
            EmailAssembly(),
            MessageAssembly(),
            NoticeAssembly(),
            Network.ProfileAssembly(),
            FileAssembly(),
            // Core
            KeyValueStoreAssembly()
        ], container: container)
    }
}
