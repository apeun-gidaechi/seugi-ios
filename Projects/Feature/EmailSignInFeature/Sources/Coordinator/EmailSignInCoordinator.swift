import SwiftUI
import EmailSignInFeatureInterface
import DIContainerInterface

public struct EmailSignInCoordinator: View {
    
    @InjectObject private var viewModel: EmailSignInViewModel
    
    public init() {}
    
    public var body: some View {
        EmailSignInView(vm: viewModel)
    }
}
