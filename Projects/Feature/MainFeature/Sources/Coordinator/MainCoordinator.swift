import SwiftUI
import BaseFeature
import DesignSystem
import HomeFeatureInterface
import ChatFeatureInterface
import ChatDetailFeatureInterface
import RoomFeatureInterface
import CreateRoomFeatureInterface
import DIContainerInterface

public struct MainCoordinator: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: Router
    
    @Inject private var homeFactory: any HomeFactory
    @Inject private var 
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            content
        }
    }
    
    @ViewBuilder
    private var content: some View {
        ZStack {
            switch appState.mainFlow {
            case .home: HomeView()
            case .chat: ChatView()
            case .room: RoomView()
            case .notification: EmptyView()
            case .profile: EmptyView()
            }
            GeometryReader { reader in
                ZStack(alignment: .bottom) {
                    SeugiBottomNavigation(selectedTab: $bottomNavigationController.selectedTab)
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
    }
}
