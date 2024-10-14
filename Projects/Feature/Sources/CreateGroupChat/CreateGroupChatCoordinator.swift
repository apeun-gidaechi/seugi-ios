import SwiftUI

struct CreateGroupChatCoordinator: View {
    @StateObject private var viewModel = CreateGroupChatViewModel()
    
    var body: some View {
        FirstCreateGroupChatView()
            .environmentObject(viewModel)
            .navigationDestination(for: CreateGroupChatPath.self) {
                switch $0 {
                case .secondCreateGroupChat: SecondCreateGroupChatView()
                        .environmentObject(viewModel)
                }
            }
    }
}
