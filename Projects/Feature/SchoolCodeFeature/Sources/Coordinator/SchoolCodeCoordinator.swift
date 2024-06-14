import SwiftUI
import DIContainer
import JoinSuccessFeatureInterface
import SwiftUIUtil

public struct SchoolCodeCoordinator: View {
    
    @Inject private var joinSuccessFactory: any JoinSuccessFactory
    
    public var body: some View {
        SchoolCodeView()
            .navigationDestination(for: SchoolCodeDestination.self) {
                switch $0 {
                case .joinSuccess: joinSuccessFactory.makeView().eraseToAnyView()
                }
            }
    }
}
