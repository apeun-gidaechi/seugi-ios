import SwiftUI
import Component
import BaseFeatureInterface
import ChatFeatureInterface
import Domain

public struct ChatView: View {
    
    // MARK: - Object
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var vm: ChatViewModel
    
    // MARK: - State
    @State private var isSearching = false
    @FocusState private var searchFocus: Bool
    
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
                            router.navigate(to: ChatDestination.chatDetail(roomId: room.id))
                        } label: {
                            SeugiChatList(type: roomType, room: room)
                        }
                        .applyAnimation()
                    }
                } failure: { _ in
                    Text("불러오기 실패")
                }
            }
            .frame(maxWidth: .infinity)
            .background(.clear)
        }
        .hideKeyboardWhenTap()
        .refreshable {
            if let selectedWorkspace = appState.selectedWorkspace {
                vm.fetchChats(workspaceId: selectedWorkspace.workspaceId)
            }
        }
        .seugiTopBar(roomType == .personal ? "채팅" : "그룹") {
            withAnimation {
                isSearching = false
            }
        }
        .hideTitle(isSearching)
        .subView {
            if isSearching {
                TextField("채팅방 검색", text: .constant(""))
                    .focused($searchFocus)
            }
        }
        .if(!isSearching) { view in
            view.hideBackButton()
                .button(.searchLine) {
                    withAnimation {
                        isSearching = true
                        searchFocus = true
                    }
                }
                .if(roomType != .personal) { view in
                    view.button(.addFill) {
                        router.navigate(to: ChatDestination.createRoom)
                    }
                    .hideBackButton()
                }
        }
    }
}
