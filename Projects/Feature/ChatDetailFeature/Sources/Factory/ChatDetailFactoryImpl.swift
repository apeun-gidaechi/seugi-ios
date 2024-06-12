import SwiftUI
import ChatDetailFeatureInterface

final class ChatDetailFactoryImpl: ChatDetailFactory {
    func makeView() -> some View {
        ChatDetailCoordinator()
    }
}
