import SwiftUI
import Component
import BaseFeatureInterface

public struct ChatView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm: ChatViewModel
    
    public init(
        vm: ChatViewModel
    ) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
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
        .task {
//            guard let workspace = appState.selectedWorkspace else { return }
//            await vm.fetchChats(workspaceId: workspace.workspaceId)
        }
    }
}
