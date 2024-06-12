import SwiftUI
import DIContainerInterface

struct OAuthSignUpCoordinator: View {
    
    @InjectObject private var viewModel: OAuthSignUpViewModel
    
    var body: some View {
        OAuthSignUpView(vm: viewModel)
    }
}
