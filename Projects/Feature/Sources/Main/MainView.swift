import SwiftUI
import Component
import DIContainer
import Domain
import Combine

public struct MainView: View {
    
    @Router private var router
    @AppState private var appState
    @EnvironmentObject private var stompManager: StompManager
    @State private var selection = 0
    
    public init() {}
    
    public var body: some View {
        SeugiBottomNavigation(selection: $selection) {
            HomeView()
                .page(icon: .homeFill)
            ChatView(roomType: .personal)
                .page(icon: .chatFill)
            ChatView(roomType: .group)
                .page(icon: .peopleFill)
            NotificationView()
                .page(icon: .notificationFill)
            ProfileView()
                .page(icon: .personFill)
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            stompManager.openSocket()
            appState.fetchWorkspaces()
            appState.subscribe { subject in
                switch subject {
                case .logout:
                    selection = 0
                    router.navigateToRoot()
                }
            }
        }
    }
}
