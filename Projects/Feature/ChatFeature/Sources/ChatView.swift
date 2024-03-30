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
                SeugiChatList()
                SeugiChatList()
            }
        }
        .seugiToolbar("채팅")
    }
}
