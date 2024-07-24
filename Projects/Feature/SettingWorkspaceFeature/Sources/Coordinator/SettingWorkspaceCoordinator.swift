import SwiftUI
import SettingWorkspaceFeatureInterface

struct SettingWorkspaceCoordinator: View {
    var body: some View {
        SettingWorkspaceView()
            .navigationDestination(for: SettingWorkspaceDestination.self) {
                switch $0 {
                case .manageMember: ManageMemberView()
                }
            }
    }
}
