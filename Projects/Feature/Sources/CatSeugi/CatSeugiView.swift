import SwiftUI
import PhotosUI
import Component
import Domain

struct CatSeugiView {
    enum Id: Hashable {
        case bottom
        case top
    }
    
    @EnvironmentObject private var mainViewModel: MainViewModel
    @EnvironmentObject private var alert: AlertProvider
    
    @StateObject private var viewModel = CatSeugiViewModel()
    
    @State private var scrollViewProxy: ScrollViewProxy?
    @FocusState private var focused
    
    init() {}
}

extension CatSeugiView: View {
    public var body: some View {
        viewModel.messages.makeView {
            VStack {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        } success: { messages in
            CustomScrollView(scrollViewProxy: $scrollViewProxy) {
                EmptyView()
                    .id(Id.top)
                ForEach(messages.indices, id: \.self) { index in
                    let message = messages[index]
                    if let member = mainViewModel.profile.data?.member {
                        let isMe = message.userId == member.id
                        ChatItemView(
                            type: isMe ? .me : .bot,
                            message: message
                        )
                    }
                }
                .padding(.horizontal, 8)
                EmptyView()
                    .id(Id.bottom)
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
            title: "캣스기",
            showShadow: true
        )
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 12) {
                makeHelperButtons()
                makeBottomTextField()
            }
        }
        .onReceive(viewModel.$sendMessageFlow) { flow in
            switch flow {
            case .success:
                scrollToBottom()
            case .failure:
                alert.present(
                    .init(title: "전송 실패")
                    .message("다시 시도해 주세요")
                )
            default:
                break
            }
            focused = true
        }
    }
    
    @ViewBuilder
    private func makeBottomTextField() -> some View {
        SeugiChatTextField("메세지 보내기", text: $viewModel.message, hasMenu: false) { action in
            switch action {
            case .sendMessage:
                guard let member = mainViewModel.profile.data?.member else { return }
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
    
    @ViewBuilder
    private func makeHelperButtons() -> some View {
        if let messages = viewModel.messages.data,
           messages.count == 1 {
            HStack(spacing: 8) {
                ForEach(["오늘 급식 뭐야?", "8월 행사 알려줘"], id: \.self) { helperText in
                    Button {
                        viewModel.message = helperText
                        guard let member = mainViewModel.profile.data?.member else { return }
                        viewModel.sendMessage(userId: member.id)
                    } label: {
                        Text(helperText)
                            .seugiColor(.gray(.g700))
                            .font(.body(.b1))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .seugiBackground(.primary(.p100))
                            .cornerRadius(12, corners: .allCorners)
                    }
                }
            }
        }
    }
    
    private func scrollToBottom() {
        scrollViewProxy?.scrollTo(Id.bottom)
    }
}
