import SwiftUI
import HomeFeatureInterface
import JoinSchoolFeatureInterface
import DIContainer

struct HomeCoordinator: View {
    
    @Inject private var joinSchoolFactory: any JoinSchoolFactory
    
    private let flow: HomeFetchFlow
    
    public init(flow: HomeFetchFlow) {
        self.flow = flow
    }
    
    var body: some View {
        HomeView(flow: flow)
            .navigationDestination(for: HomeDestination.self) {
                switch $0 {
                case .joinSchool: joinSchoolFactory.makeView().eraseToAnyView()
                }
            }
    }
}
