import SwiftUI
import PhotosUI
import Component
import Domain
import SwiftUtil
import ScopeKit

let pagingInterval = 50

struct ChatDetailView: View {
    enum Id: Hashable {
        case bottom, top
    }
    
    @EnvironmentObject private var alert: AlertProvider
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var keyboardMonitor: KeyboardMonitor
    
    @StateObject private var viewModel: ChatDetailViewModel
    @StateObject private var fileViewModel = FileViewModel()
    
    @State private var isDrawerOpen: Bool = false
    @State private var scrollViewProxy: ScrollViewProxy?
    @State private var showPhotoPicker: Bool = false
    @State private var photo: PhotosPickerItem?
    
    private let room: Room
    
    init(room: Room) {
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
            CustomScrollView(
                scrollViewProxy: $scrollViewProxy,
                spacing: 0,
                reversed: true
            ) {
                EmptyView().id(Id.top)
                    .onAppear {
                        print("ChatDetailView.body - touched top")
                        // TODO: FETCH NEW DATA
                    }
                ForEach(messages, id: \.id) { message in
                    ChatMessageCell(
                        message: message
                    ) {
                        switch $0 {
                        case .clickImage:
                            if let url = message.message.split(separator: MessageConstant.fileSeparator) // TODO: refactor
                                .first
                                .map(String.init) {
                                router.navigate(to: MainDestination.imagePreview(
                                    .init(url: URL(string: url) ?? .aboutBlank))
                                )
                            }
                        case .downloadFile:
                            // TODO: Handle
                            break
                        }
                    }
                }
                .padding(.horizontal, 8)
                EmptyView().id(Id.bottom)
            }
            .seugiBackground(.primary(.p050))
        } failure: { _ in
            VStack {
                SeugiError("채팅 불러오기 실패", image: .sadButRelievedFace)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .searchable("메세지, 이미지, 파일 검색", text: $viewModel.searchText, isSearching: $viewModel.isSearching)
        .safeAreaInset(edge: .bottom, content: safeAreaContent)
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
            selection: self.$photo,
            matching: .any(of: [.images, .screenshots, .livePhotos])
        )
        .onChange(of: isDrawerOpen) { _ in
            hideKeyboard()
        }
        .onChange(of: photo) {
            guard let photo = $0 else { return }
            self.photo = nil
            fileViewModel.uploadPhoto(photo: photo)
        }
        .onReceive(fileViewModel.$imageUploadFlow) { flow in
            switch flow {
            case .success(let file):
                router.navigate(to: MainDestination.imagePreview(
                    .init(
                        url: URL(string: file.url) ?? .aboutBlank
                    ) {
                        .init(icon: .sendFill) {
                            viewModel.sendMessage()
                            router.popToStack()
                        }
                    }
                ))
            case .failure:
                alert.present(
                    .init(title: "업로드 실패")
                    .message("잠시 후 다시 시도해 주세요")
                )
            default:
                break
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
                    viewModel.sendMessage()
                case .imageMenu:
                    showPhotoPicker = true
                case .fileMenu:
                    break
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            .seugiBackground(.primary(.p050))
        }
    }
}

extension ChatDetailView {
    private func scrollToBottom(animated: Bool = false) {
        if animated {
            Task {
                try? await Task.sleep(for: .seconds(0.22))
                withAnimation(.spring(duration: 0.2)) {
                    scrollViewProxy?.scrollTo(Id.bottom)
                }
            }
        } else {
            scrollViewProxy?.scrollTo(Id.bottom)
        }
    }
}
