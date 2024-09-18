import SwiftUI
import PhotosUI
import Component
import Domain
import DIContainer

let pagingInterval = 50

public struct ChatDetailView: View {
    
    enum Id: Hashable {
        case bottom
        case top
    }
    
    @EnvironmentObject private var alert: AlertProvider
    @StateObject private var viewModel = ChatDetailViewModel()
    @AppState private var appState
    @Router private var router
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - State
    /* drawer */
    @State private var isDrawerOpen = false
    /* scroll */
    @State private var scrollViewProxy: ScrollViewProxy?
    /* search */
    @State private var isSearching = false
    @State private var searchText = ""
    @FocusState private var searchFocus: Bool
    /* photo picker */
    @State private var showPhotoPicker = false
    
    // MARK: - Properties
    private let room: Room
    
    public init(
        room: Room
    ) {
        self.room = room
    }
    
    public var body: some View {
        viewModel.messages.makeView {
            ProgressView()
        } success: { messages in
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        Color.clear
                            .id(Id.top)
                            .onAppear {
                                // TODO: Handle paging
                                //                                    let messages = viewModel.messages.data ?? []
                                //                                    messages.count - 1 / pagingInterval
                                //                                    guard let index = data.firstIndex(where: { $0.community.communityId == community.community.communityId }) else { return }
                                //
                                //                                      if index % pagingInterval == (pagingInterval - 1) && index / pagingInterval == (data.count - 1) / pagingInterval {
                                //                                          await viewModel.fetchNextCommunities()
                                //                                      }
                            }
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            if message.isDetailText {
                                if let text = message.getDetailText(room: room) {
                                    ChatItemDetailView(text: text)
                                }
                            } else if let member = appState.profile.data?.member {
                                let author = room.findUserOrUnknownUser(id: message.userId)
                                let type: ChatItemViewCellType = if author.id == member.id {
                                    .me
                                } else {
                                    .other(
                                        isFirst: messages.isFirstMessage(at: index),
                                        isLast: messages.isLastMessage(at: index)
                                    )
                                }
                                ChatItemView(author: author, message: message, type: type, joinedUserCount: room.joinUserId.count)
                            }
                        }
                        Color.clear
                            .id(Id.bottom)
                    }
                    .onAppear {
                        // 시작시 아래로 스크롤
                        self.scrollViewProxy = scrollViewProxy
                        scrollToBottom()
                    }
                }
                .seugiBackground(.primary(.p050))
            }
        } failure: { _ in
            SeugiError("채팅 불러오기 실패", image: .sadButRelievedFace)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .safeAreaInset(edge: .bottom) {
            if !isSearching {
                makeBottomTextField()
            }
        }
        .hideKeyboardWhenTap()
        .seugiTopBar(room.chatName) {
            if isSearching {
                withAnimation {
                    isSearching = false
                }
            } else {
                dismiss()
            }
        }
        .hideTitle(isSearching)
        .subView {
            if isSearching {
                TextField("메세지, 이미지, 파일 검색", text: $searchText)
                    .focused($searchFocus)
            }
        }
        .showShadow()
        .if(!isSearching) { view in
            view.button(.searchLine) {
                withAnimation {
                    isSearching = true
                    searchFocus = true
                }
            }
            .button(.hamburgerHorizontalLine) {
                isDrawerOpen = true
            }
        }
        .seugiDrawer(isOpen: $isDrawerOpen) {
            ChatDetailDrawer(room: room) { action in
                switch action {
                case .leftRoom:
                    alert.present("채팅방을 나가시겠습니까?")
                        .primaryButton("나가기") {
                            viewModel.left(roomId: room.id)
                        }
                        .secondaryButton("닫기") {}
                        .show()
                }
            }
        }
        .onChange(of: isDrawerOpen) { _ in
            hideKeyboard()
        }
        .onAppear {
            viewModel.fetchMessages(roomId: room.id)
            viewModel.subscribe(roomId: room.id)
            viewModel.subscribe { subject in
                switch subject {
                case .messageLoaded:
                    Task {
                        try? await Task.sleep(for: .seconds(0.2))
                        scrollToBottom()
                    }
                case .messagesFetched:
                    scrollToBottom()
                }
            }
        }
        .onDisappear {
            viewModel.unsubscribe(roomId: room.id)
        }
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $viewModel.photo,
            matching: .any(of: [.images, .screenshots, .livePhotos])
        )
        .onChange(of: viewModel.photo) { _ in } // TODO: impl
        .onChange(of: viewModel.leftRoomFlow) { _ in
            router.popToStack()
        } failure: { err in
            if case .http(let res) = err {
                alert.present(res.message)
                    .show()
            } else {
                alert.present("알 수 없는 에러")
                    .show()
            }
        }
    }
    
    @ViewBuilder
    private func makeBottomTextField() -> some View {
        SeugiChatTextField("메세지 보내기", text: $viewModel.message) { action in
            switch action {
            case .sendMessage:
                viewModel.sendMessage(room: room)
            case .imageMenu:
                showPhotoPicker = true
            case .fileMenu:
                break
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 8)
        .seugiBackground(.primary(.p050))
        .onTapGesture {
            Task {
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation {
                    scrollToBottom()
                }
            }
        }
    }
    
    private func scrollToBottom() {
        scrollViewProxy?.scrollTo(Id.bottom)
    }
}
