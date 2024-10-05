import SwiftUI
import Component
import Domain

public struct ChatView: View {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    @StateObject private var viewModel: ChatViewModel
    
    @FocusState private var searchFocus: Bool
    
    private let roomType: RoomType
    
    public init(roomType: RoomType) {
        self.roomType = roomType
        self._viewModel = .init(wrappedValue: .init(roomType: roomType))
    }
    
    public var body: some View {
        viewModel.mergedRooms.makeView {
            ProgressView()
        } success: { rooms in
            if rooms.isEmpty {
                SeugiError("채팅방이 없어요", image: .kissingFaceWithClosedEyes)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(rooms, id: \.id) { room in
                            SeugiChatList(type: roomType, room: room)
                                .button {
                                    router.navigate(to: MainDestination.chatDetail(room: room))
                                }
                                .scaledButtonStyle()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        } failure: { _ in
            SeugiError("불러오기 실패", image: .faceWithDiagonalMouth)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .hideKeyboardWhenTap()
        .refreshable {
            if let selectedWorkspace = appState.selectedWorkspace {
                viewModel.fetchChats(workspaceId: selectedWorkspace.workspaceId)
            }
        }
        .seugiTopBar(
            title: roomType.text,
            showBackButton: false
        )
        .buttons {
            if roomType != .personal {
                .init(icon: .addFill) {
                    router.navigate(to: MainDestination.firstCreateGroupChat)
                }
            }
        }
        .searchable(
            "채팅방 검색",
            text: $viewModel.searchText,
            isSearching: $viewModel.isSearching
        )
        .onAppear {
//            viewModel.subscribe { subject in
//                switch subject {
//                case .refreshFailure:
//                    appState.logout()
//                }
//            }
        }
        .onReceive(appState.$selectedWorkspace) {
            guard let id = $0?.workspaceId else { return }
            viewModel.fetchChats(workspaceId: id)
        }
    }
}
