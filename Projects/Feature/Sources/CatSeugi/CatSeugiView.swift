import SwiftUI
import PhotosUI
import Component
import Domain
import DIContainer

public struct CatSeugiView: View {
    
    enum Id: Hashable {
        case bottom
        case top
    }
    
    @AppState private var appState
    @StateObject private var viewModel = CatSeugiViewModel()
    
    // MARK: - State
    /* scroll */
    @State private var scrollViewProxy: ScrollViewProxy?
    
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
                                let type: ChatItemViewCellType = if message.userId == member.id {
                                    .me
                                } else {
                                    .ai(
                                        isFirst: messages.isFirstMessage(at: index),
                                        isLast: messages.isLastMessage(at: index)
                                    )
                                }
                                ChatItemView(author: member, message: message, type: type, joinedUserCount: 2)
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
                
            }
        }
    }
    
    @ViewBuilder
    private func makeBottomTextField() -> some View {
        SeugiChatTextField("메세지 보내기", text: $viewModel.message) { action in
            switch action {
            case .sendMessage:
//                viewModel.sendMessage(room: room)
                break
            case .imageMenu:
//                showPhotoPicker = true
                break
            case .fileMenu:
                break
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 8)
        .seugiBackground(.primary(.p050))
        .onTapGesture {
            Task {
                try? await Task.sleep(for: .seconds(0.3))
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
