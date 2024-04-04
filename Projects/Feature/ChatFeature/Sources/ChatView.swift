import SwiftUI
import DesignSystem

public struct ChatView: View {
    
    var navigateToChatDetail: () -> Void
    
    public init(
        navigateToChatDetail: @escaping () -> Void
    ) {
        self.navigateToChatDetail = navigateToChatDetail
    }
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Button {
                    navigateToChatDetail()
                } label: {
                    SeugiChatList()
                }
                .applyAnimation()
                Button {
                    navigateToChatDetail()
                } label: {
                    SeugiChatList()
                }
                .applyAnimation()
            }
        }
        .seugiToolbar("채팅")
    }
}
