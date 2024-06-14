import LaunchScreenFeatureInterface
import SwiftUI

final class LaunchScreenFactoryImpl: LaunchScreenFactory {
    func makeView() -> some View {
        LaunchScreenView()
    }
}
