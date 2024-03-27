import SwiftUI
import BaseFeature
import StartFeature
import EmailSignInFeature
import EmailSignUpFeature
import OAuthSignUpFeature
import JoinSchoolFeature
import SelectingJobFeature
import MainFeature

public struct RootView: View {
    
    @EnvironmentObject var navController: NavigationController
    
    private var isAuthed = false
    
    public init() {}
    
    public var body: some View {
        if !isAuthed {
            NavigationStack(path: $navController.onboardingPath) {
                StartView()
                    .navigationDestination(for: ViewType.Onboarding.self) { viewType in
                        switch viewType {
                        case .start: StartView()
                        case .emailSignIn: EmailSignInView()
                        case .emailSignUp: EmailSignUpView()
                        case .oauthSignUp: OAuthSignUpView()
                        case .joinSchool: JoinSchoolView()
                        case .selectingJob: SelectingJobView()
                        default: EmptyView()
                        }
                    }
            }
        } else {
            NavigationStack(path: $navController.mainPath) {
                MainView()
                    .navigationDestination(for: ViewType.Main.self) { viewType in
                        switch viewType {
                        case .main: MainView()
                        case .chatDetail: EmptyView()
                        }
                    }
            }
        }
    }
}
