import SwiftUI
import BaseFeature
import StartFeature
import EmailSignInFeature
import EmailSignUpFeature
import OAuthSignUpFeature
import JoinSchoolFeature
import SelectingJobFeature

public struct RootView: View {
    
    @EnvironmentObject var navController: NavigationController
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navController.path) {
            StartView()
                .navigationDestination(for: ViewType.self) { viewType in
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
    }
}
