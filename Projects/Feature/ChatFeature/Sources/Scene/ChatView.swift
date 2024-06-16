import SwiftUI
import Component
import BaseFeatureInterface
import ChatFeatureInterface
import Domain

public struct ChatView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var vm: ChatViewModel
    
    private let roomType: RoomType
    
    public init(roomType: RoomType) {
        self.roomType = roomType
    }
    
    private var rooms: FetchFlow<[Room]> {
        roomType == .personal ? vm.personalRooms : vm.groupRooms
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                rooms.makeView {
                    ProgressView()
                } success: { rooms in
                    ForEach(rooms, id: \.id) { room in
                        Button {
                            router.navigate(to: ChatDestination.chatDetail)
                        } label: {
                            SeugiChatList(type: roomType, room: room)
                        }
                        .applyAnimation()
                    }
                } failure: { _ in
                    Text("-")
                }
            }
        }
        .seugiTopBar(roomType == .personal ? "채팅" : "그룹")
        .hideBackButton()
        .if(roomType == .personal) {
            $0
                .button(.searchLine) {
                    //
                }
        } else: {
            $0
                .button(.addFill) {
                    router.navigate(to: ChatDestination.createRoom)
                }
                .button(.searchLine) {
                    //
                }
                .hideBackButton()
        }
    }
}
