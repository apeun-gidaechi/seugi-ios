import SwiftUI
import SettingProfileFeatureInterface

final class SettingProfileFactoryImpl: SettingProfileFactory {
    func makeView() -> some View {
        SettingProfileCoordinator()
    }
}
