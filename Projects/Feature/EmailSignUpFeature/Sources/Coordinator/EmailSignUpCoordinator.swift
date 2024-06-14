import SwiftUI
import EmailSignInFeatureInterface
import EmailSignUpFeatureInterface
import DIContainer
import EmailVerificationFeatureInterface
import SwiftUIUtil

public struct EmailSignUpCoordinator: View {
    
    @InjectObject private var viewModel: EmailSignUpViewModel
    @Inject private var emailSignInFactory: any EmailSignInFactory
    @Inject private var emailVerificationFactory: any EmailVerificationFactory
    
    public init() {}
    
    public var body: some View {
        EmailSignUpView(viewModel: viewModel)
            .navigationDestination(for: EmailSignUpDestination.self) {
                switch $0 {
                case .emailSignIn: emailSignInFactory.makeView().eraseToAnyView()
                case .emailVerification(let name, let email, let password): emailVerificationFactory.makeView(name: name, email: email, password: password).eraseToAnyView()
                }
            }
    }
}
