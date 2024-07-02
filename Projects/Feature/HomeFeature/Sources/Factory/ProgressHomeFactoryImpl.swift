import SwiftUI
import HomeFeatureInterface

final class ProgressHomeFactoryImpl: ProgressHomeFactory {
    func makeView() -> some View {
        ProgressHomeView()
    }
}
