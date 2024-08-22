import SwiftUI
import PhotosUI
import Component
import BaseFeatureInterface
import Domain
import DIContainer

let pagingInterval = 50

enum ChatDetailSupporterType: Hashable {
    case bottom
    case top
}

public struct ChatDetailView: View {
    
    @InjectObject private var viewModel: ChatDetailViewModel
    @EnvironmentObject private var appState: AppState
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
    
    private let room: Room
    
    public init(
        room: Room
    ) {
        self.room = room
    }
    
    public var body: some View {
        ZStack {
            viewModel.messages.makeView {
                ProgressView()
            } success: { messages in
                ScrollViewReader { scrollViewProxy in
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            Color.clear
                                .frame(height: 1)
                                .id(ChatDetailSupporterType.top)
                                .onAppear {
//                                    let messages = viewModel.messages.data ?? []
//                                    messages.count - 1 / pagingInterval
//                                    guard let index = data.firstIndex(where: { $0.community.communityId == community.community.communityId }) else { return }
//                                      
//                                      if index % pagingInterval == (pagingInterval - 1) && index / pagingInterval == (data.count - 1) / pagingInterval {
//                                          await viewModel.fetchNextCommunities()
//                                      }
                                }
                            ForEach(Array(messages.enumerated()), id: \.element.id) { idx, message in
                                if message.type == .enter {
                                    let userId = message.eventList?.first ?? -1
                                    let firstMember = room.findUserById(id: userId)
                                    let eventCount = message.eventList?.count
                                    var text = "\(firstMember?.name ?? "")"
                                    if let eventCount, eventCount > 1 {
                                        let _ = text += " 외 \(eventCount - 1)명이 채팅방에 입장 했습니다"
                                    }
                                    ChatItemDetailView(text: text)
                                } else {
                                    let isFirst = idx == 0 || (messages[idx - 1].userId != message.userId) || ![.message, .deleteMessage].contains(messages[idx - 1].type)
                                    let isLast = idx == messages.count - 1 || messages[idx + 1].userId != message.userId
                                    let author = room.findUserById(id: message.userId) ?? .init(
                                        id: message.userId,
                                        email: "",
                                        birth: "",
                                        name: "(알 수 없음)",
                                        picture: ""
                                    )
                                    let userId = appState.profile.data?.member.id ?? -1
                                    let type: ChatItemViewCellType = author.id == userId ? .me : .other(isFirst: isFirst, isLast: isLast)
                                    ChatItemView(author: author, message: message, type: type, joinedUserCount: room.joinUserId.count)
                                }
                            }
                            Color.clear
                                .frame(height: 68)
                                .id(ChatDetailSupporterType.bottom)
                        }
                        .onAppear {
                            self.scrollViewProxy = scrollViewProxy
                            scrollViewProxy.scrollTo(ChatDetailSupporterType.bottom, anchor: .bottom)
                        }
                    }
                    .seugiBackground(.primary(.p050))
                }
            } failure: { _ in
                Text("-")
            }
            if !isSearching {
                BottomTextField()
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
        .seugiDrawer(isDrawerOpen: $isDrawerOpen) {
            drawerBody
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
        .onChange(of: viewModel.photo) { _ in }
    }
    
    @ViewBuilder
    private func BottomTextField() -> some View {
        GeometryReader { reader in
            VStack {
                Spacer()
                Color.seugi(.primary(.p050))
                    .frame(maxWidth: .infinity)
                    .frame(height: reader.safeAreaInsets.bottom + 56 - 12, alignment: .bottom) // 56: bottom nav height, 12: just margin
            }
            .ignoresSafeArea()
            SeugiChatTextField("메세지 보내기", text: $viewModel.message) {
                switch $0 {
                case .sendMessage:
                    viewModel.sendMessage(room: room)
                case .imageMenu:
                    showPhotoPicker = true
                case .fileMenu:
                    break
                }
            }
            .toBottom()
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        scrollToBottom()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var drawerBody: some View {
        VStack(spacing: 0) {
            Text("멤버")
                .padding(.leading, 16)
                .toLeading()
                .font(.subtitle(.s2))
                .frame(height: 40)
            SeugiDivider(thickness: .thin)
            if let selectedWorkspace = appState.selectedWorkspace {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        SeugiMemberList(type: .invitation)
                        ForEach(room.joinUserId, id: \.id) { member in
                            SeugiMemberList(type: .normal(member: member, role: .getRole(memberId: member.id, workspace: selectedWorkspace)))
                        }
                    }
                }
            }
            Spacer()
            SeugiDivider(thickness: .thin)
            HStack(spacing: 16) {
                makeImageButton(.logoutLine) {
                    // handle
                }
                
                Spacer()
                makeImageButton(.notificationFill) {
                    // handle
                }
                makeImageButton(.settingFill) {
                    // handle
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
        }
    }
    
    @ViewBuilder
    private func makeImageButton(
        _ icon: SeugiIconography,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Image(icon: icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 28, height: 28)
                .seugiColor(.gray(.g600))
        }
    }
    
    private func scrollToBottom() {
        scrollViewProxy?.scrollTo(ChatDetailSupporterType.bottom)
    }
}
