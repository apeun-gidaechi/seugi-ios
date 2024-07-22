import SwiftUI
import CreateGroupChatFeatureInterface

final class CreateRoomFactoryImpl: CreateRoomFactory {
    func makeView() -> some View {
        CreateRoomCoordinator()
    }
}
