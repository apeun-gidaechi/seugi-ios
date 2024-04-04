import SwiftUI
import DesignSystem

enum ChatType: Hashable {
    case chat(id: Int)
    case bottom
}

public struct ChatDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var isDrawerOpen = false
    @State private var scrollViewProxy: ScrollViewProxy?

    public init() {}
    
    public var body: some View {
        ZStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack {
                        ChatItemDateView(date: "2024년 3월 21일 목요일").id(ChatType.chat(id: 1))
                        ChatItemView(author: "이강현", type: .other).id(ChatType.chat(id: 2))
                        ChatItemView(author: "이강현", type: .me).id(ChatType.chat(id: 3))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 4))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 5))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 6))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 7))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 8))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 9))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 10))
                        ChatItemView(author: "박재욱", type: .other).id(ChatType.chat(id: 11))
                        Color.clear
                            .frame(height: 52)
                            .id(ChatType.bottom)
                    }
                    .onAppear {
                        self.scrollViewProxy = scrollViewProxy
                        scrollViewProxy.scrollTo(ChatType.bottom)
                    }
                }
            }
            .background(Color.seugi(.primary(.p050)))
            SeugiChatTextField("메세지 보내기", text: $text) {
                // handle more
            } sendButtonTapped: {
                // handle send message
                if let scrollViewProxy {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(ChatType.bottom)
                    }
                }
            }
            .toBottom()
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .hideKeyboardWhenTap()
        .seugiToolbar(
            "노영재",
            icon1: DesignSystemAsset.searchLine.swiftUIImage,
            icon1ButtonTapped: {
                // handle searching
            },
            icon2: DesignSystemAsset.hamburgerHorizontalLine.swiftUIImage,
            icon2ButtonTapped: {
                isDrawerOpen = true
            }, backButtonTapped: {
                dismiss()
            })
        .seugiDrawer(isDrawerOpen: $isDrawerOpen) {
            Text("갱갱ㅇ")
        }
    }
}
