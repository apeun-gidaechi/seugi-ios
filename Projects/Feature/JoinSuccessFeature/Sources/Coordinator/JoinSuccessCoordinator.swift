import SwiftUI
import SelectingJobFeatureInterface
import JoinSuccessFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct JoinSuccessCoordinator: View {
    
    @Inject private var selectingJobFactory: any SelectingJobFactory
    
    public var body: some View {
        JoinSuccessView()
            .navigationDestination(for: JoinSuccessDestination.self) {
                switch $0 {
                case .selectingJob: selectingJobFactory.makeView().eraseToAnyView()
                }
            }
    }
}
