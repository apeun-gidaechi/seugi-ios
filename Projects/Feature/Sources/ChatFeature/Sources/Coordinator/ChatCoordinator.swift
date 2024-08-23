import SwiftUI
import DIContainer
import SwiftUIUtil
import Domain

public struct ChatCoordinator: View {
    
    private let roomType: RoomType
    
    public init(roomType: RoomType) {
        self.roomType = roomType
    }
    
    public var body: some View {
        ChatView(
            roomType: roomType
        )
        .navigationDestination(for: ChatDestination.self) {
            switch $0 {
            case .chatDetail(let room): ChatDetailCoordinator(room: room)
            case .createGroupChat: CreateGroupChatCoordinator()
            }
        }
    }
}
