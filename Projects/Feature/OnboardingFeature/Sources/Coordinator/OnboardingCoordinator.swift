import SwiftUI
import BaseFeatureInterface
import StartFeatureInterface
import EmailSignInFeatureInterface
import EmailSignUpFeatureInterface
import OAuthSignUpFeatureInterface
import SwiftUIUtil
import DIContainer
import OnboardingFeatureInterface

public struct OnboardingCoordinator: View {
    
    @EnvironmentObject var router: Router
    @Inject private var startFactory: any StartFactory
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            startFactory.makeView().eraseToAnyView()
                .navigationDestination(for: OnboardingDestination.self) {
                    switch $0 {
                    case .emailSignIn: EmailSignInView()
                    case .emailSignUp: EmailSignUpView()
                    case .emailVerification(let name, let email, let password): EmailVerificationView(viewModel: .init(), name: name, email: email, password: password)
                    case .start: StartView()
                    }
                }
        }
    }
}
