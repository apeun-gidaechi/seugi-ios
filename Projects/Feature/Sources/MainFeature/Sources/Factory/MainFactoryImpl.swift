import SwiftUI

final class MainFactoryImpl: MainFactory {
    func makeView() -> some View {
        MainView()
    }
}
