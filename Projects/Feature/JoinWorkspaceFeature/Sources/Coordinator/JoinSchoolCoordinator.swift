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
        SchoolCodeView()
            .environmentObject(joinWorkspaceViewModel)
            .navigationDestination(for: JoinWorkspaceDestination.self) { destination in
                Group {
                    switch destination {
                    case .waitingJoin: WaitingJoinView()
                    case .joinSuccess: JoinSuccessView()
                    case .selectingJob: SelectingJobView()
                    }
                }
                .environmentObject(joinWorkspaceViewModel)
            }
    }
}
