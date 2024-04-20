import DIContainerInterface
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
import Swinject

extension DependencyProvider {
    func register() {
        _ = Assembler([
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
            StartAssembly()
        ], container: container)
    }
}
