import SwiftUI
import HomeFeatureInterface
import JoinWorkspaceFeatureInterface
import CreateWorkspaceFeatureInterface
import DIContainer
import Component

struct HomeCoordinator: View {
    
    @Inject private var joinWorkspaceFactory: any JoinWorkspaceFactory
    @Inject private var createWorkspaceFactory: any CreateWorkspaceFactory
    
    private let flow: HomeFetchFlow
    
    public init(flow: HomeFetchFlow) {
        self.flow = flow
    }
    
    var body: some View {
        HomeView(flow: flow)
            .navigationDestination(for: HomeDestination.self) {
                switch $0 {
                case .joinWorkspace: joinWorkspaceFactory.makeView().eraseToAnyView()
                case .createWorkspace: createWorkspaceFactory.makeView().eraseToAnyView()
                }
            }
    }
}
