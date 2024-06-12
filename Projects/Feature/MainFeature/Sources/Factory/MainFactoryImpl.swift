import SwiftUI
import MainFeatureInterface

final class MainFactoryImpl: MainFactory {
    func makeView() -> some View {
        MainCoordinator()
    }
}
