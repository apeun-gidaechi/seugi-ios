import DIContainer

// Feature
import ChatDetailFeature
import ChatFeature
import CreateRoomFeature
import EmailSignInFeature
import EmailSignUpFeature
import EmailVerificationFeature
import HomeFeature
import JoinSchoolFeature
import LaunchScreenFeature
import MainFeature
import OAuthSignUpFeature
import OnboardingFeature
import RootFeature
import StartFeature
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
            OAuthSignUpAssembly(),
            ChatDetailAssembly(),
            ChatFeature.ChatAssembly(),
            CreateRoomAssembly(),
            EmailSignInAssembly(),
            EmailSignUpAssembly(),
            EmailVerificationAssembly(),
            HomeAssembly(),
            JoinSchoolAssembly(),
            LaunchScreenAssembly(),
            MainAssembly(),
            OAuthSignUpAssembly(),
            OnboardingAssembly(),
            RootAssembly(),
            StartAssembly(),
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
