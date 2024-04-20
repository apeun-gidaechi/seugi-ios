import SwiftUI
import DesignSystem

enum ChatType: Hashable {
    case chat(id: Int)
    case bottom
}

public struct ChatDetailView: View {
    
    @State private var text = ""
    @State private var isDrawerOpen = false
    @State private var scrollViewProxy: ScrollViewProxy?
    
    public init() {}
    
    public var body: some View {
        ZStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(spacing: 0) {
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
                .background(Color.seugi(.primary(.p050)))
            }
            GeometryReader { reader in
                VStack {
                    Spacer()
                    Color.seugi(.primary(.p050))
                        .frame(maxWidth: .infinity)
                        .frame(height: reader.safeAreaInsets.bottom + 56 - 12, alignment: .bottom) // 56: bottom nav height, 12: just margin
                }
                .ignoresSafeArea()
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
        }
        .hideKeyboardWhenTap()
        .seugiTopBar("노영재")
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
                    SeugiMemberList(type: .invitation)
                    ForEach(0..<30, id: \.self) {
                        SeugiMemberList(type: .normal)
                            .id($0)
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
}
