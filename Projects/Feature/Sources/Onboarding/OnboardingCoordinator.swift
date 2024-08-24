import SwiftUI
import SwiftUIUtil
import DIContainer

public struct OnboardingCoordinator: View {
    
    @StateObject private var registerEmailViewModel = RegisterEmailViewModel()
    
    public init() {}
    
    public var body: some View {
        StartView()
            .navigationDestination(for: OnboardingDestination.self) { destination in
                Group {
                    switch destination {
                    case .emailSignIn: LoginEmailView()
                    case .emailSignUp: RegisterEmailView()
                    case .emailVerification: RegisterEmailVerificationView()
                    case .start: StartView()
                    }
                }
                .environmentObject(registerEmailViewModel)
            }
    }
}
