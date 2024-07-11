import SwiftUI
import Component
import BaseFeatureInterface
import DIContainer
import Domain

enum ChatType: Hashable {
    case chat(id: Int)
    case bottom
}

public struct ChatDetailView: View {
    
    @InjectObject private var viewModel: ChatDetailViewModel
    
    @State private var isDrawerOpen = false
    @State private var scrollViewProxy: ScrollViewProxy?
    
    private let room: Room
    
    public init(room: Room) {
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
                            ForEach(Array(messages.enumerated()), id: \.element.id) { idx, message in
                                if let author = room.findUserById(id: message.userId) {
                                    let isFirst = idx == 0 || messages[idx - 1].userId != message.userId
                                    let isLast = idx == messages.count - 1 || messages[idx + 1].userId != message.userId
                                    ChatItemView(author: author, message: message, type: .other(isFirst: isFirst, isLast: isLast), joinedUserCount: room.joinUserId.count)
                                }
                            }
                            Color.clear
                                .frame(height: 60)
                                .id(ChatType.bottom)
                        }
                        .onAppear {
                            self.scrollViewProxy = scrollViewProxy
                            scrollViewProxy.scrollTo(ChatType.bottom, anchor: .bottom)
                        }
                    }
                    .background(Color.seugi(.primary(.p050)))
                }
            } failure: { _ in
                Text("-")
            }
            BottomTextField()
        }
        .hideKeyboardWhenTap()
        .seugiTopBar(room.chatName)
        .showShadow()
        .button(.searchLine) {
            // handle searching
        }
        .button(.hamburgerHorizontalLine) {
            isDrawerOpen = true
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
                    scrollToBottom()
                case .messagesFetched:
                    scrollToBottom()
                }
            }
        }
        .onDisappear {
            viewModel.unsubscribe(roomId: room.id)
        }
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
                // handle tapped icon
            } sendButtonTapped: {
                viewModel.sendMessage(room: room)
                if scrollViewProxy != nil {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        scrollToBottom()
                    }
                }
            }
            .toBottom()
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
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
            ScrollView {
                LazyVStack(spacing: 0) {
//                    SeugiMemberList(type: .invitation, member: T##RetrieveProfile)
//                    ForEach(0..<30, id: \.self) {
//                        SeugiMemberList(type: .normal)
//                            .id($0)
//                    }
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
        scrollViewProxy?.scrollTo(ChatType.bottom)
    }
}
