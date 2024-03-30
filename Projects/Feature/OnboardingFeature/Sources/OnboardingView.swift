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
            StartView {
                navController.navigateTo(.emailSignIn)
            } navigateToOAuthSignUp: {
                navController.navigateTo(.oauthSignUp)
            }
            .navigationDestination(for: ViewType.Onboarding.self) { viewType in
                switch viewType {
                case .emailSignIn: EmailSignInView()
                case .emailSignUp: EmailSignUpView()
                case .oauthSignUp: OAuthSignUpView()
                case .selectingJob: SelectingJobView {
                    navController.navigateTo(.emailSignUp)
                } navigateToOAuthSignUp: {
                    navController.navigateTo(.oauthSignUp)
                }
                }
            }
        }
    }
}
