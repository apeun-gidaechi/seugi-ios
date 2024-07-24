import SwiftUI
import BaseFeatureInterface
import SwiftUIUtil
import DIContainer
import OnboardingFeatureInterface

public struct OnboardingCoordinator: View {
    
    @EnvironmentObject var router: Router
    
    public init() {}
    
    public var body: some View {
        StartView()
            .navigationDestination(for: OnboardingDestination.self) {
                switch $0 {
                case .emailSignIn: LoginEmailView()
                case .emailSignUp: RegisterEmailView()
                case .emailVerification(let name, let email, let password): RegisterEmailVerificationView(viewModel: .init(), name: name, email: email, password: password)
                case .start: StartView()
                }
            }
    }
}
