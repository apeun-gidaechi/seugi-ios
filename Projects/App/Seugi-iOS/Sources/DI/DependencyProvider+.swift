import DIContainer

// Feature
import ChatDetailFeature
import ChatFeature
import CreateRoomFeature
import EmailSignInFeature
import EmailSignUpFeature
import EmailVerificationFeature
import WaitingJoinFeature
import HomeFeature
import JoinSchoolFeature
import JoinSuccessFeature
import LaunchScreenFeature
import MainFeature
import OAuthSignUpFeature
import OnboardingFeature
import RootFeature
import SchoolCodeFeature
import SelectingJobFeature
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
            WaitingJoinAssembly(),
            HomeAssembly(),
            JoinSchoolAssembly(),
            JoinSuccessAssembly(),
            LaunchScreenAssembly(),
            MainAssembly(),
            OAuthSignUpAssembly(),
            OnboardingAssembly(),
            RootAssembly(),
            SchoolCodeAssembly(),
            SelectingJobAssembly(),
            StartAssembly(),
            NotificationAssembly(),
            ProfileAssembly(),
            // Domain
            MemberAssembly(),
            Network.ChatAssembly(),
            WorkspaceAssembly(),
            EmailAssembly(),
            MessageAssembly(),
            // Core
            KeyValueStoreAssembly()
        ], container: container)
    }
}
