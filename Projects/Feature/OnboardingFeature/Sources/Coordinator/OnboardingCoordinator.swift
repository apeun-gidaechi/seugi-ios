import SwiftUI
import BaseFeatureInterface
import SwiftUIUtil
import DIContainer
import OnboardingFeatureInterface

public struct OnboardingCoordinator: View {
    
    @EnvironmentObject var router: Router
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
