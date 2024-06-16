import SwiftUI
import MainFeatureInterface
import ChatFeatureInterface

final class MainFactoryImpl: MainFactory {
    func makeView() -> some View {
        MainView()
    }
}
