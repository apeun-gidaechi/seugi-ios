import SwiftUI
import EmailSignUpFeatureInterface
import EmailSignInFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct SelectingJobCoordinator: View {
    
    @Inject private var emailSignUpFactory: any EmailSignUpFactory
    @Inject private var emailSignInFactory: any EmailSignInFactory
    
    public init() {}
    
    public var body: some View {
        SelectingJobView()
            .navigationDestination(for: SelectingJobDestination.self) {
                switch $0 {
                case .emailSignUp: emailSignUpFactory.makeView().eraseToAnyView()
                case .emailSignIn: emailSignInFactory.makeView().eraseToAnyView()
                }
            }
    }
}
