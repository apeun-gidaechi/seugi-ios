import SwiftUI
import Component
import Domain
import Combine

public struct MainView: View {
    
    @Router private var router
    @AppState private var appState
    @State private var selection: Int = 0
    
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
            appState.subscribe { subject in
                switch subject {
                case .logout:
                    selection = 0
                    router.navigateToRoot()
                }
            }
        }
        .onChange(of: appState.selectedWorkspace) { _ in
            appState.fetchWorkspaces()
        }
    }
}
