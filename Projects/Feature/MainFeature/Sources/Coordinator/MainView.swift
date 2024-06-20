import SwiftUI
import BaseFeatureInterface
import Component
import HomeFeatureInterface
import ChatFeatureInterface
import ChatDetailFeatureInterface
import CreateRoomFeatureInterface
import DIContainer

public struct MainView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    
    @Inject private var homeFactory: any HomeFactory
    @Inject private var chatFactory: any ChatFactory
    @InjectObject private var chatViewModel: ChatViewModel
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            content
        }
    }
    
    @ViewBuilder
    private var content: some View {
        ZStack {
            switch appState.mainFlow.selectedTab {
            case .home: homeFactory.makeView().eraseToAnyView()
            case .chat: chatFactory.makeView(roomType: .personal).eraseToAnyView()
            case .room: chatFactory.makeView(roomType: .group).eraseToAnyView()
            case .notification: EmptyView()
            case .profile: EmptyView()
            }
            GeometryReader { reader in
                ZStack(alignment: .bottom) {
                    SeugiBottomNavigation(tabs: $appState.mainFlow)
                        .shadow(color: Color.black.opacity(0.04), radius: 12)
                    VStack {
                        Color.white
                            .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        Spacer()
                        Color.white
                            .frame(height: reader.safeAreaInsets.bottom, alignment: .bottom)
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .environmentObject(chatViewModel)
        .onAppear {
            guard let workspace = appState.selectedWorkspace else { return }
            chatViewModel.fetchChats(workspaceId: workspace.workspaceId)
        }
    }
}
