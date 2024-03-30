import SwiftUI
import DesignSystem

public struct ChatDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    
    public init() {}
    
    public var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ChatItemDateView(date: "2024년 3월 21일 목요일")
                    ChatItemView(author: "이강현", type: .other)
                    ChatItemView(author: "이강현", type: .me)
                    ChatItemView(author: "박재욱", type: .other)
                }
            }
            SeugiChatTextField("메세지 보내기", text: $text) {
                // handle more
            } sendButtonTapped: {
                // handle send message
            }
            .toBottom()
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
        .seugiToolbar("노영재") {
            dismiss()
        }
        .seugiIcon(icon1: DesignSystemAsset.searchLine.swiftUIImage, 
                   icon1ButtonTapped: {
            // handle searching
        },
                   icon2: DesignSystemAsset.hamburgerHorizontalLine.swiftUIImage) {
            // handle side menu
        }
    }
}
