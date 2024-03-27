import SwiftUI
import BaseFeature
import DesignSystem
import HomeFeature

public struct MainView: View {
    
    @EnvironmentObject var navController: NavigationController
    @StateObject var bottomNavigationController = BottomNavigationController()
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack {
                switch bottomNavigationController.selectedTab {
                case .home: EmptyView()
                case .chat: EmptyView()
                case .people: EmptyView()
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
}
