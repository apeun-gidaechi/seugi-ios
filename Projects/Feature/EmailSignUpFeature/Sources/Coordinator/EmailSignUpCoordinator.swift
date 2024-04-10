import SwiftUI
import EmailSignInFeatureInterface
import EmailSignUpFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct EmailSignUpCoordinator: View {
    
    @InjectObject private var viewModel: EmailSignUpViewModel
    @Inject private var emailSignInFactory: any EmailSignInFactory
    
    public init() {}
    
    public var body: some View {
        EmailSignUpView(vm: viewModel)
            .navigationDestination(for: EmailSignUpDestination.self) {
                switch $0 {
                case .emailSignIn: emailSignInFactory.makeView().eraseToAnyView()
                }
            }
    }
}
