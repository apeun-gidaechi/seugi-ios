import SwiftUI
import DIContainer

struct CreateGroupChatCoordinator: View {
    @InjectObject private var createGroupChatViewModel: CreateGroupChatViewModel
    
    var body: some View {
        FirstCreateGroupChatView()
            .navigationDestination(for: CreateGroupChatDestination.self) { destination in
                Group {
                    switch destination {
                    case .secondCreateGroupChat: SecondCreateGroupChatView()
                    }
                }
                .environmentObject(createGroupChatViewModel)
            }
            .environmentObject(createGroupChatViewModel)
    }
}
