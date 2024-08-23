import SwiftUI
import Domain

final class ChatFactoryImpl: ChatFactory {
    func makeView(roomType: RoomType) -> some View {
        ChatCoordinator(
            roomType: roomType
        )
    }
}
