import SwiftUI
import SelectingJobFeatureInterface
import EmailSignUpFeatureInterface
import EmailSignInFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct EmailSignInCoordinator: View {
    
    @InjectObject private var viewModel: EmailSignInViewModel
    @Inject private var selectingJobFactory: any SelectingJobFactory
    
    public init() {}
    
    public var body: some View {
        EmailSignInView(vm: viewModel)
            .navigationDestination(for: EmailSignInDesination.self) {
                switch $0 {
                case .selectingJob: selectingJobFactory.makeView().eraseToAnyView()
                }
            }
    }
}
