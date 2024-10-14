import SwiftUI
import PhotosUI
import Component
import Domain
import SwiftUtil
import ScopeKit

let pagingInterval = 50

public struct ChatDetailView: View {
    enum Id: Hashable {
        case bottom
        case top
    }
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var alert: AlertProvider
    @EnvironmentObject private var appState: AppViewModel
    @EnvironmentObject private var router: RouterViewModel
    
    @StateObject private var viewModel: ChatDetailViewModel
    
    @State private var isDrawerOpen: Bool = false
    @State private var scrollViewProxy: ScrollViewProxy?
    @State private var showPhotoPicker: Bool = false
    
    @FocusState private var searchFocus: Bool
    
    private let room: Room
    
    public init(room: Room) {
        self.room = room
        self._viewModel = StateObject(wrappedValue: ChatDetailViewModel(room: room))
    }
}

extension ChatDetailView {
    public var body: some View {
        viewModel.mergedMessages.makeView {
            VStack {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        } success: { messages in
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    Color.clear
                        .frame(height: 0.001)
                        .id(Id.top)
                        .onAppear {
                            print("ChatDetailView.body - touched top")
                            // TODO: FETCH NEW DATA
                        }
                    LazyVStack(spacing: 0) {
                        ForEach(messages, id: \.id) { message in
                            ChatMessageCell(
                                message: message
                            ) {
                                switch $0 {
                                case .clickImage:
                                    if let url = message.message.split(separator: MessageConstant.fileSeparator) // TODO: refactor
                                        .first
                                        .map(String.init) {
                                        router.navigate(to: MainDestination.imagePreview(URL(string: url) ?? .aboutBlank))
                                    }
                                case .downloadFile:
                                    // TODO: Handle
                                    break
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .onAppear {
                        self.scrollViewProxy = scrollViewProxy
                        self.scrollToBottom()
                    }
                    Color.clear
                        .frame(height: 0.001)
                        .id(Id.bottom)
                }
                .seugiBackground(.primary(.p050))
            }
        } failure: { _ in
            VStack {
                SeugiError("채팅 불러오기 실패", image: .sadButRelievedFace)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .safeAreaInset(edge: .bottom, content: safeAreaContent)
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
        .searchable("메세지, 이미지, 파일 검색", text: $viewModel.searchText, isSearching: $viewModel.isSearching)
        .seugiDrawer(isOpen: $isDrawerOpen) {
            ChatDetailDrawer(room: room) { action in
                switch action {
                case .leftRoom:
                    alert.present(
                        .init(title: "채팅방을 나가시겠습니까?")
                        .primaryButton("나가기") {
                            viewModel.left(roomId: room.id)
                        }.secondaryButton("닫기")
                    )
                }
            }
        }
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $viewModel.photo,
            matching: .any(of: [.images, .screenshots, .livePhotos])
        )
        .onChange(of: isDrawerOpen) { _ in
            hideKeyboard()
        }
        .onChange(of: viewModel.photo) { _ in } // TODO: impl
        .onReceive(viewModel.$messages) {
            if case .success = $0 {
                scrollToBottom()
            }
        }
        .onReceive(viewModel.$leftRoomFlow) { flow in
            switch flow {
            case .success:
                router.popToStack()
            case .failure(let error):
                let message = run {
                    if let error = error as? APIError,
                       case .http(let res) = error {
                        res.message
                    } else {
                        "잠시 후 다시 시도해 주세요"
                    }
                }
                alert.present(
                    .init(title: "채팅방을 나갈 수 없습니다")
                    .message(message)
                )
            default:
                break
            }
        }
    }
    
    @ViewBuilder
    private func safeAreaContent() -> some View {
        if !viewModel.isSearching {
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
    }
}

extension ChatDetailView {
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
