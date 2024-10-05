import SwiftUI
import PhotosUI
import Component
import Domain
import SwiftUtil

let pagingInterval = 50

public struct ChatDetailView: View {
    
    enum Id: Hashable {
        case bottom
        case top
    }
    
    @EnvironmentObject private var alert: AlertProvider
    @StateObject private var viewModel: ChatDetailViewModel
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
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
        self._viewModel = StateObject(wrappedValue: ChatDetailViewModel(room: room))
    }
    
    public var body: some View {
        viewModel.messages.makeView {
            ProgressView()
        } success: { messages in
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        Color.clear
                            .id(Id.bottom)
                            .onAppear {
                                // 시작시 아래로 스크롤
                                self.scrollViewProxy = scrollViewProxy
                                scrollToBottom()
                            }
                        Group {
                            ForEach(messages.indices, id: \.self) { index in
                                ChatMessageCell(
                                    messages: messages,
                                    currentIndex: index,
                                    room: room
                                ) {
                                    switch $0 {
                                    case .clickImage:
                                        if let url = messages[index].message.split(separator: MessageConstant.fileSeparator) // TODO: refactor
                                            .first
                                            .map(String.init) {
                                            router.navigate(to: MainDestination.imagePreview(URL(string: url) ?? .aboutBlank))
                                        }
                                    }
                                }
                            }
                        }
                        .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                    }
                    .padding(.horizontal, 8)
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
                }
                .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                .seugiBackground(.primary(.p050))
            }
        } failure: { _ in
            SeugiError("채팅 불러오기 실패", image: .sadButRelievedFace)
        }
        .safeAreaInset(edge: .bottom) {
            if !isSearching {
                makeBottomTextField()
            }
        }
        .hideKeyboardWhenTap()
        .seugiTopBar(
            title: room.chatName,
            showShadow: true
        )
        .buttons {
            SeugiTopBarButton(icon: .hamburgerHorizontalLine) {
                isDrawerOpen = true
            }
        }
        .searchable("메세지, 이미지, 파일 검색", text: $searchText, isSearching: $isSearching)
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
        .onReceive(viewModel.subject) { subject in
            switch subject {
            case .messageLoaded:
                scrollToBottom(animated: true)
            case .messagesFetched:
                scrollToBottom()
            }
        }
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $viewModel.photo,
            matching: .any(of: [.images, .screenshots, .livePhotos])
        )
        .onChange(of: viewModel.photo) { _ in } // TODO: impl
        .onReceive(viewModel.$leftRoomFlow) { flow in
            switch flow {
            case .success:
                router.popToStack()
            case .failure:
                alert.present("채팅방을 나갈 수 없습니다")
                    .message("잠시 후 다시 시도해 주세요")
                    .show()
            default:
                break
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
            scrollToBottom(animated: true)
        }
    }
    
    private func scrollToBottom(animated: Bool = false) {
        if animated {
            Task {
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation {
                    scrollViewProxy?.scrollTo(Id.bottom)
                }
            }
        } else {
            scrollViewProxy?.scrollTo(Id.bottom)
        }
    }
}
