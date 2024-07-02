import SwiftUI
import ChatDetailFeatureInterface

final class ChatDetailFactoryImpl: ChatDetailFactory {
    func makeView(roomId: String) -> some View {
        ChatDetailCoordinator(roomId: roomId)
    }
}
