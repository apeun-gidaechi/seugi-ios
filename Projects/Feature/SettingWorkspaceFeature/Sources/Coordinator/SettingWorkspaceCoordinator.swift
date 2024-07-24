import SwiftUI
import SettingWorkspaceFeatureInterface

public struct SettingWorkspaceCoordinator: View {
    
    public init() {}
    
    public var body: some View {
        SettingWorkspaceView()
            .navigationDestination(for: SettingWorkspaceDestination.self) {
                switch $0 {
                case .manageMember: ManageMemberView()
                }
            }
    }
}
