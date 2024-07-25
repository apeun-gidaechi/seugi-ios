import SwiftUI
import WorkspaceDetailFeatureInterface
import SettingWorkspaceFeatureInterface
import DIContainer
import SwiftUIUtil

struct WorkspaceDetailCoordinator: View {
    
    @Inject private var settingWorkspaceFactory: any SettingWorkspaceFactory
    
    var body: some View {
        WorkspaceDetailView()
            .navigationDestination(for: WorkspaceDetailDestination.self) {
                switch $0 {
                case .settingWorkspace: settingWorkspaceFactory.makeView().eraseToAnyView()
                case .workspaceMembers: EmptyView()
                }
            }
    }
}
