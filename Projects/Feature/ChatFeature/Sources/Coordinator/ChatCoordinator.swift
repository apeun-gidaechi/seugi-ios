import SwiftUI
import ChatDetailFeatureInterface
import DIContainer
import SwiftUIUtil

public struct ChatCoordinator: View {
    
    @Inject private var chatDetailFactory: any ChatDetailFactory
    @InjectObject private var chatViewModel: ChatViewModel
    
    public var body: some View {
        ChatView(
            vm: chatViewModel
        )
        .navigationDestination(for: ChatDestination.self) {
            switch $0 {
            case .chatDetail: chatDetailFactory.makeView().eraseToAnyView()
            }
        }
    }
}
