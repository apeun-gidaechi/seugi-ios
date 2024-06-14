import SwiftUI
import EmailSignUpFeatureInterface
import EmailSignInFeatureInterface
import DIContainer
import SwiftUIUtil

public struct EmailSignInCoordinator: View {
    
    @InjectObject private var viewModel: EmailSignInViewModel
    @Inject private var emailSignUpFactory: any EmailSignUpFactory
    
    public init() {}
    
    public var body: some View {
        EmailSignInView(vm: viewModel)
            .navigationDestination(for: EmailSignInDesination.self) {
                switch $0 {
                case .emailSignUp: emailSignUpFactory.makeView().eraseToAnyView()
                }
            }
    }
}
