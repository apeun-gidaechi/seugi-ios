import SwiftUI
import Component
import Domain

public struct ChatView: View {
    
    @Router private var router
    @AppState private var appState
    @EnvironmentObject private var viewModel: ChatViewModel
    
    // MARK: - State
    @State private var isSearching = false
    @FocusState private var searchFocus: Bool
    
    private let roomType: RoomType
    
    public init(roomType: RoomType) {
        self.roomType = roomType
    }
    
    private var rooms: FetchFlow<[Room]> {
        roomType == .personal ? viewModel.personalRooms : viewModel.groupRooms
    }
    
    private var searchText: Binding<String> {
        roomType == .personal ? $viewModel.personalSearchText : $viewModel.groupSearchText
    }
    
    private var searchedRooms: FetchFlow<[Room]> {
        roomType == .personal ? viewModel.searchedPersonalRooms : viewModel.searchedGroupRooms
    }
    
    private var mergedRooms: FetchFlow<[Room]> {
        isSearching ? searchedRooms : rooms
    }
    
    public var body: some View {
        ScrollView {
            mergedRooms.makeView {
                ProgressView()
            } success: { rooms in
                if rooms.isEmpty {
                    SeugiError("채팅방이 없어요", image: .kissingFaceWithClosedEyes)
                } else {
                    LazyVStack(spacing: 0) {
                        ForEach(rooms, id: \.id) { room in
                            Button {
                                router.navigate(to: MainDestination.chatDetail(room: room))
                            } label: {
                                SeugiChatList(type: roomType, room: room)
                            }
                            .applyAnimation()
                        }
                    }
                }
            } failure: { _ in
                SeugiError("불러오기 실패", image: .faceWithDiagonalMouth)
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
        .hideKeyboardWhenTap()
        .refreshable {
            if let selectedWorkspace = appState.selectedWorkspace {
                viewModel.fetchChats(workspaceId: selectedWorkspace.workspaceId)
            }
        }
        .onTapGesture {
            if isSearching {
                withAnimation {
                    isSearching = false
                    viewModel.clearSearchText()
                }
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
                TextField("채팅방 검색", text: searchText)
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
                        router.navigate(to: MainDestination.firstCreateGroupChat)
                    }
                    .hideBackButton()
                }
        }
        .onAppear {
            viewModel.subscribe { subject in
                switch subject {
                case .refreshFailure:
                    appState.logout()
                }
            }
        }
        .onDisappear {
            viewModel.clearSearchText()
        }
    }
}
