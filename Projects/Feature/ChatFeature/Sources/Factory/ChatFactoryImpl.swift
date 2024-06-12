import SwiftUI
import ChatFeatureInterface

final class ChatFactoryImpl: ChatFactory {
    func makeView() -> some View {
        ChatCoordinator()
    }
}
