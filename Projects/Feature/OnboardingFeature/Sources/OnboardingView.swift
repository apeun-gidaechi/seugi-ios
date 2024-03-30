import SwiftUI
import BaseFeature
import StartFeature
import EmailSignInFeature
import EmailSignUpFeature
import JoinSchoolFeature
import OAuthSignUpFeature
import SelectingJobFeature

public struct OnboardingView: View {
    
    @StateObject private var navController = OnboardingNavigationController()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navController.path) {
            StartView()
        }
        .navigationDestination(for: ViewType.Onboarding.self) { viewType in
            switch viewType {
            case .start: StartView()
            case .emailSignIn: EmailSignInView()
            case .emailSignUp: EmailSignUpView()
            case .joinSchool: JoinSchoolView()
            case .oauthSignUp: OAuthSignUpView()
            case .selectingJob: SelectingJobView()
            }
        }
    }
}
