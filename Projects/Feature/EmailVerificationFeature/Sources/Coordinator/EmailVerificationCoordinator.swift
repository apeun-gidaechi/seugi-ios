import SwiftUI
import DIContainerInterface

public struct EmailVerificationCoordinator: View {
    
    @InjectObject private var viewModel: EmailVerificationViewModel
    
    public init() {}
    
    public var body: some View {
        EmailVerificationView(
            viewModel: viewModel
        )
    }
}
