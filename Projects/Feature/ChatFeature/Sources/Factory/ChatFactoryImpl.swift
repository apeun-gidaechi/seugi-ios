import SwiftUI
import ChatFeatureInterface
import Domain

final class ChatFactoryImpl: ChatFactory {
    func makeView(roomType: RoomType) -> some View {
        ChatCoordinator(
            roomType: roomType
        )
    }
}
