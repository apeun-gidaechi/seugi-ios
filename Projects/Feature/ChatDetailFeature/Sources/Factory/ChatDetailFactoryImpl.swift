import SwiftUI
import ChatDetailFeatureInterface
import Domain

final class ChatDetailFactoryImpl: ChatDetailFactory {
    func makeView(room: Room) -> some View {
        ChatDetailCoordinator(room: room)
    }
}
