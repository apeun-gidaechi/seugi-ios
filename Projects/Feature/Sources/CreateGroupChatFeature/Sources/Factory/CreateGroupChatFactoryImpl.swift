import SwiftUI

final class CreateGroupChatFactoryImpl: CreateGroupChatFactory {
    func makeView() -> some View {
        CreateGroupChatCoordinator()
    }
}
