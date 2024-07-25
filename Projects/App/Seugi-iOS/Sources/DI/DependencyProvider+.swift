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
import CreateNotificationFeature
import CreateWorkspaceFeature
import SettingProfileFeature
import SettingWorkspaceFeature
import WorkspaceDetailFeature

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
            NotificationFeature.NotificationAssembly(),
            ProfileFeature.ProfileAssembly(),
            CreateNotificationAssembly(),
            CreateWorkspaceAssembly(),
            SettingProfileAssembly(),
            SettingWorkspaceAssembly(),
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
