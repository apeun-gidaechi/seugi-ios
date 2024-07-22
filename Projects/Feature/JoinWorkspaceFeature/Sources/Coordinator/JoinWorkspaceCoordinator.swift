import SwiftUI
import BaseFeatureInterface
import DIContainer
import SwiftUIUtil
import JoinWorkspaceFeatureInterface

public struct JoinWorkspaceCoordinator: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var joinWorkspaceViewModel = JoinWorkspaceViewModel()
    
    public init() {}
    
    public var body: some View {
        JoinWorkspaceCodeView()
            .environmentObject(joinWorkspaceViewModel)
            .navigationDestination(for: JoinWorkspaceDestination.self) { destination in
                Group {
                    switch destination {
                    case .waitingJoin: JoinWorkspaceFinishView()
                    case .joinSuccess: JoinWorkspaceSuccessView()
                    case .selectingJob: JoinWorkspaceRoleView()
                    }
                }
                .environmentObject(joinWorkspaceViewModel)
            }
    }
}
