import SwiftUI
import CreateGroupChatFeatureInterface

final class CreateGroupChatFactoryImpl: CreateGroupChatFactory {
    func makeView() -> some View {
        CreateGroupChatCoordinator()
    }
}
