import SwiftUI

final class SettingProfileFactoryImpl: SettingProfileFactory {
    func makeView() -> some View {
        SettingProfileCoordinator()
    }
}
