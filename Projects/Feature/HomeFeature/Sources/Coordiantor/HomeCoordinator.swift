import SwiftUI
import HomeFeatureInterface
import JoinWorkspaceFeatureInterface
import CreateWorkspaceFeatureInterface
import WorkspaceDetailFeatureInterface
import DIContainer
import Component

struct HomeCoordinator: View {
    
    @Inject private var workspaceDetailFactory: any WorkspaceDetailFactory
    @Inject private var createWorkspaceFactory: any CreateWorkspaceFactory
    @Inject private var joinWorkspaceFactory: any JoinWorkspaceFactory
    
    private let flow: HomeFetchFlow
    
    public init(flow: HomeFetchFlow) {
        self.flow = flow
    }
    
    var body: some View {
        HomeView(flow: flow)
            .navigationDestination(for: HomeDestination.self) {
                switch $0 {
                case .workspaceDetail: workspaceDetailFactory.makeView().eraseToAnyView()
                case .createWorkspace: createWorkspaceFactory.makeView().eraseToAnyView()
                case .joinWorkspace: joinWorkspaceFactory.makeView().eraseToAnyView()
                }
            }
    }
}
