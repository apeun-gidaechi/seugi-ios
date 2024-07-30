import SwiftUI
import SettingWorkspaceFeatureInterface

final class SettingWorkspaceFactoryImpl: SettingWorkspaceFactory {
    func makeView() -> some View {
        SettingWorkspaceCoordinator()
    }
}
