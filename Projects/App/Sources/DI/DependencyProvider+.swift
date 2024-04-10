import DIContainerInterface
import ChatDetailFeature
import ChatFeature
import EmailSignInFeature
import EmailSignUpFeature
import HomeFeature
import JoinSchoolFeature
import JoinSuccessFeature
import LaunchScreenFeature
import MainFeature
import OAuthSignUpFeature
import OnboardingFeature
import RoomFeature
import SchoolCodeFeature
import SelectingJobFeature
import StartFeature
import Swinject

extension DependencyProvider {
    func register() {
        _ = Assembler([
            EmailSignInAssembly(),
            EmailSignUpAssembly(),
            JoinSchoolAssembly(),
            JoinSuccessAssembly(),
            OAuthSignUpAssembly(),
            OnboardingAssembly(),
            SchoolCodeAssembly(),
            SelectingJobAssembly(),
            StartAssembly()
        ], container: container)
    }
}
