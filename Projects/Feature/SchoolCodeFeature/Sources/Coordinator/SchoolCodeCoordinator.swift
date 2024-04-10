import SwiftUI
import DIContainerInterface
import JoinSuccessFeatureInterface
import SwiftUIUtil

public struct SchoolCodeCoordinator: View {
    
    @InjectObject private var viewModel: SchoolCodeViewModel
    @Inject private var joinSuccessFactory: any JoinSuccessFactory
    
    public var body: some View {
        SchoolCodeView(vm: viewModel)
            .navigationDestination(for: SchoolCodeDestination.self) {
                switch $0 {
                case .joinSuccess: joinSuccessFactory.makeView().eraseToAnyView()
                }
            }
    }
}
