import SwiftUI
import StartFeatureInterface

class StartFactoryImpl: StartFactory {
    func makeView() -> some View {
        StartView()
    }
}
