import SwiftUI
import RootFeatureInterface

final class RootFactoryImpl: RootFactory {
    func makeView() -> some View {
        RootView()
    }
}
