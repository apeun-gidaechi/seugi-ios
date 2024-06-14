import SwiftUI
import DIContainer

public struct EmailVerificationCoordinator: View {
    
    @InjectObject private var viewModel: EmailVerificationViewModel
    
    private let name: String
    private let email: String
    private let password: String
    
    public init(
        name: String,
        email: String,
        password: String
    ) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    public var body: some View {
        EmailVerificationView(
            viewModel: viewModel,
            name: name,
            email: email,
            password: password
        )
    }
}
