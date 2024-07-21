import SwiftUI
import HomeFeatureInterface

final class HomeFactoryImpl: HomeFactory {
    func makeView(flow: HomeFetchFlow) -> some View {
        HomeCoordinator(flow: flow)
    }
}
