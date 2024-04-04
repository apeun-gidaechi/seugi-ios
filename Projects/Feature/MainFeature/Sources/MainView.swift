import SwiftUI
import BaseFeature
import DesignSystem
import HomeFeature
import ChatFeature
import ChatDetailFeature
import RoomFeature
import CreateRoomFeature
//import RoomDetailFeature

public struct MainView: View {
    @StateObject private var bottomNavigationController = BottomNavigationController()
    @StateObject private var navController = MainNavigationController()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navController.path) {
            content
                .navigationDestination(for: ViewType.Main.self) { viewType in
                    switch viewType {
                    case .chatDetail: ChatDetailView()
//                    case .roomDetail: RoomDetailView()
                    case .firstCreateRoom: FirstCreateRoomView(
                        navigateToSecondCreateRoom: {
                            navController.navigateTo(.SecondCreateRoom)
                        }
                    )
                    case .SecondCreateRoom: SecondCreateRoomView()
                    default: EmptyView()
                    }
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        ZStack {
            switch bottomNavigationController.selectedTab {
            case .home: HomeView()
            case .chat: ChatView { navController.navigateTo(.chatDetail) }
            case .room: RoomView(
                navigateToRoomDetail: {
                    navController.navigateTo(.roomDetail)
                },
                navigateToCreateRoom: {
                    navController.navigateTo(.firstCreateRoom)
                }
            )
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
