import SwiftUI
import EmailSignUpFeatureInterface
import DIContainerInterface

public struct SelectingJobCoordinator: View {
    
    @Inject private var emailSignUpFactory: any EmailSignUpFactory
    
    public init() {}
    
    public var body: some View {
        SelectingJobView()
            .navigationDestination(for: SelectingJobDestination.self) {
                switch $0 {
                case .emailSignUp: emailSignUpFactory.makeView().eraseToAnyView()
                }
            }
    }
}
