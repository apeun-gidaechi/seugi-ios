import SwiftUI
import HomeFeatureInterface

final class HomeFactoryImpl: HomeFactory {
    func makeView() -> some View {
        HomeCoordinator()
    }
}
