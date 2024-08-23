import SwiftUI
import DIContainer
import Component

struct HomeCoordinator: View {
    
    private let flow: HomeFetchFlow
    
    public init(flow: HomeFetchFlow) {
        self.flow = flow
    }
    
    var body: some View {
        HomeView(flow: flow)
            .navigationDestination(for: HomeDestination.self) {
                switch $0 {
                case .workspaceDetail: WorkspaceDetailCoordinator()
                case .createWorkspace: CreateWorkspaceCoordinator()
                case .joinWorkspace: JoinWorkspaceCoordinator()
                }
            }
    }
}
