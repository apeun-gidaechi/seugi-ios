import SwiftUI
import ChatDetailFeatureInterface
import CreateRoomFeatureInterface
import DIContainer
import SwiftUIUtil
import Domain

public struct ChatCoordinator: View {
    
    @Inject private var chatDetailFactory: any ChatDetailFactory
    @Inject private var createChatFactory: any CreateRoomFactory
    
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
            case .chatDetail(let room): chatDetailFactory.makeView(room: room).eraseToAnyView()
            case .createRoom: createChatFactory.makeView().eraseToAnyView()
            }
        }
    }
}
