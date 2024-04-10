import SwiftUI
import DesignSystem
import BaseFeature

public struct ChatView: View {
    
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Button {
                    router.navigate(to: ChatDestination.chatDetail)
                } label: {
                    SeugiChatList()
                }
                .applyAnimation()
                Button {
                    router.navigate(to: ChatDestination.chatDetail)
                } label: {
                    SeugiChatList()
                }
                .applyAnimation()
            }
        }
        .seugiTopBar("채팅")
        .hideBackButton()
        .button(.searchLine) {
            //
        }
    }
}
