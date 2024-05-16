import DIContainerInterface

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
import RoomFeature
import RootFeature
import SchoolCodeFeature
import SelectingJobFeature
import StartFeature

// Domain
import AuthDomain
import ChatDomain

// Core
import UserDefault

// SPM
import Swinject

extension DependencyProvider {
    func register() {
        _ = Assembler([
            // Feature
            OAuthSignUpAssembly(),
            ChatDetailAssembly(),
            ChatAssembly(),
            CreateRoomAssembly(),
            EmailSignInAssembly(),
            EmailSignUpAssembly(),
            EmailVerificationAssembly(),
            WaitingJoinAssembly(),
            HomeAssembly(),
            JoinSchoolAssembly(),
            JoinSuccessAssembly(),
            MainAssembly(),
            OAuthSignUpAssembly(),
            OnboardingAssembly(),
            RoomAssembly(),
            RootAssembly(),
            SchoolCodeAssembly(),
            SelectingJobAssembly(),
            StartAssembly(),
            // Domain
            AuthDomainAssembly(),
            ChatDomainAssembly(),
            // Core
            KeyValueStoreAssembly()
        ], container: container)
    }
}
