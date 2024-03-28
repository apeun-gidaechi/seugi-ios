import SwiftUI
import DesignSystem

public struct ChatView: View {
    
    public init() {}
    
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
