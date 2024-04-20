import SwiftUI
import EmailSignUpFeatureInterface
import EmailSignInFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct EmailSignInCoordinator: View {
    
    @InjectObject private var viewModel: EmailSignInViewModel
    
    public init() {}
    
    public var body: some View {
        EmailSignInView(vm: viewModel)
    }
}
