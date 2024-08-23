import SwiftUI

final class RootFactoryImpl: RootFactory {
    func makeView() -> some View {
        RootView()
    }
}
