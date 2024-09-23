import SwiftUI
import PhotosUI
import Component
import Domain

public struct CatSeugiView: View {
    
    enum Id: Hashable {
        case bottom
        case top
    }
    
    @AppState private var appState
    @EnvironmentObject private var alert: AlertProvider
    @StateObject private var viewModel = CatSeugiViewModel()
    
    // MARK: - State
    @State private var scrollViewProxy: ScrollViewProxy?
    @FocusState private var focused
    
    public init() {}
    
    public var body: some View {
        viewModel.messages.makeView {
            ProgressView()
        } success: { messages in
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
                        Color.clear
                            .id(Id.top)
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            if let member = appState.profile.data?.member {
                                let isMe = message.userId == member.id
                                ChatItemView(
                                    author: isMe ? member : .just(name: "캣스기"),
                                    type: isMe ? .me : .ai,
                                    config: ChatItemConfig(
                                        message: message,
                                        isFirst: messages.isFirstMessage(at: index),
                                        isLast: messages.isLastMessage(at: index),
                                        joinUserCount: 2
                                    )
                                )
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
            makeBottomTextField()
        }
        .hideKeyboardWhenTap()
        .seugiTopBar("캣스기")
        .showShadow()
        .onAppear {
            viewModel.subscribe { effect in
                switch effect {
                case .messagesFetched:
                    scrollToBottom()
                case .sendMessageFailure:
                    alert.present("전송 실패")
                        .message("다시 시도해 주세요")
                        .show()
                }
            }
            focused = true
        }
    }
    
    @ViewBuilder
    private func makeBottomTextField() -> some View {
        SeugiChatTextField("메세지 보내기", text: $viewModel.message, hasMenu: false) { action in
            switch action {
            case .sendMessage:
                guard let member = appState.profile.data?.member else {
                    return
                }
                viewModel.sendMessage(userId: member.id)
            default:
                break
            }
        }
        .focused($focused)
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
