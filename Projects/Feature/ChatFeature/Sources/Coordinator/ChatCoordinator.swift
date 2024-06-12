import SwiftUI
import ChatDetailFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct ChatCoordinator: View {
    
    @Inject private var chatDetailFactory: any ChatDetailFactory
    
    public var body: some View {
        ChatView()
            .navigationDestination(for: ChatDestination.self) {
                switch $0 {
                case .chatDetail: chatDetailFactory.makeView().eraseToAnyView()
                }
            }
    }
}
