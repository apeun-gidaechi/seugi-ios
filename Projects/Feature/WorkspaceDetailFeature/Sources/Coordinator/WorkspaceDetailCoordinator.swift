import SwiftUI
import WorkspaceDetailFeatureInterface
import SettingWorkspaceFeatureInterface
import JoinWorkspaceFeatureInterface
import CreateWorkspaceFeatureInterface
import DIContainer
import SwiftUIUtil

struct WorkspaceDetailCoordinator: View {
    
    @Inject private var joinWorkspaceFactory: any JoinWorkspaceFactory
    @Inject private var createWorkspaceFactory: any CreateWorkspaceFactory
    @Inject private var settingWorkspaceFactory: any SettingWorkspaceFactory
    
    var body: some View {
        WorkspaceDetailView()
            .navigationDestination(for: WorkspaceDetailDestination.self) {
                switch $0 {
                case .settingWorkspace: settingWorkspaceFactory.makeView().eraseToAnyView()
                case .workspaceMembers: WorkspaceMembersView()
                case .createWorkspace: createWorkspaceFactory.makeView().eraseToAnyView()
                case .joinWorkspace: joinWorkspaceFactory.makeView().eraseToAnyView()
                }
            }
    }
}
