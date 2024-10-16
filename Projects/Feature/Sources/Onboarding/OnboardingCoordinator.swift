import SwiftUI
import SwiftUIUtil

struct OnboardingCoordinator: View {
    @StateObject private var registerEmailViewModel = RegisterEmailViewModel()
    
    var body: some View {
        StartView().navigationDestination(for: OnboardingDestination.self) {
            switch $0 {
            case .emailSignIn: LoginEmailView()
            case .emailSignUp: RegisterEmailView().environmentObject(registerEmailViewModel)
            case .emailVerification: RegisterEmailVerificationView().environmentObject(registerEmailViewModel)
            }
        }
    }
}
