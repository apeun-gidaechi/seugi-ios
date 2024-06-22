import SwiftUI
import Component
import DomainTesting

public struct ChatListPreview: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SeugiChatList(room: .mock())
                SeugiChatList(room: .mock())
                SeugiChatList(room: .mock())
            }
        }
    }
}
