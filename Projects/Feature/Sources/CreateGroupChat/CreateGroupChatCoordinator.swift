import SwiftUI

struct CreateGroupChatCoordinator: View {
    @StateObject private var viewModel = CreateGroupChatViewModel()
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    var body: some View {
        FirstCreateGroupChatView()
            .environmentObject(viewModel)
            .environmentObject(mainViewModel)
            .navigationDestination(for: CreateGroupChatPath.self) { path in
                Group {
                    switch path {
                    case .secondCreateGroupChat: SecondCreateGroupChatView()
                    }
                }
                .environmentObject(viewModel)
                .environmentObject(mainViewModel)
            }
    }
}
