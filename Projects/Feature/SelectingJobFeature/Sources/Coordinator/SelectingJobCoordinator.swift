import SwiftUI
import EmailSignInFeatureInterface
import WaitingJoinFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct SelectingJobCoordinator: View {
    
    @Inject private var emailSignInFactory: any EmailSignInFactory
    @Inject private var waitingJoinFactory: any WaitingJoinFactory
    
    public init() {}
    
    public var body: some View {
        SelectingJobView()
            .navigationDestination(for: SelectingJobDestination.self) {
                switch $0 {
                case .waitingJoin: waitingJoinFactory.makeView().eraseToAnyView()
                case .emailSignIn: emailSignInFactory.makeView().eraseToAnyView()
                }
            }
    }
}
