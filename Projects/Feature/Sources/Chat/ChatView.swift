import SwiftUI
import Component
import Domain
import ScopeKit

struct ChatView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @StateObject private var viewModel: ChatViewModel
    
    @FocusState private var searchFocus: Bool
    
    private let roomType: RoomType
    
    init(roomType: RoomType) {
        self.roomType = roomType
        self._viewModel = .init(wrappedValue: .init(roomType: roomType))
    }
}

extension ChatView: View {
    var body: some View {
        ScrollView {
            viewModel.mergedRooms.makeView {
                ProgressView()
            } success: { rooms in
                if rooms.isEmpty {
                    SeugiError("채팅방이 없어요", image: .kissingFaceWithClosedEyes)
                } else {
                    LazyVStack(spacing: 0) {
                        ForEach(rooms, id: \.id) { room in
                            Button {
                                let configuredRoom = mainViewModel.profile.data?.member.id
                                    .let { userId in room.setupOnline(userId: userId) } ?? room

                                router.navigate(to: MainDestination.chatDetail(room: configuredRoom))
                            } label: {
                                SeugiChatList(type: roomType, room: room)
                            }
                            .scaledButtonStyle()
                        }
                    }
                }
            } failure: { _ in
                SeugiError("불러오기 실패", image: .faceWithDiagonalMouth)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .scrollIndicators(.hidden)
        .refreshable {
            if let selectedWorkspace = mainViewModel.selectedWorkspace {
                viewModel.onAppear(workspaceId: selectedWorkspace.workspaceId)
            }
        }
        .hideKeyboardWhenTap()
        .seugiTopBar(
            title: roomType.text,
            showBackButton: false
        )
        .buttons {
            .init(icon: .addFill) {
                switch roomType {
                case .personal:
                    router.navigate(to: MainDestination.workspaceMembers)
                case .group:
                    router.navigate(to: MainDestination.createGroupChatCoordinator)
                }
            }
        }
        .searchable(
            "채팅방 검색",
            text: $viewModel.searchText,
            isSearching: $viewModel.isSearching
        )
        .onChange(of: mainViewModel.selectedWorkspace, initial: true) {
            guard let id = $0?.workspaceId else { return }
            viewModel.onAppear(workspaceId: id)
        }
    }
}
