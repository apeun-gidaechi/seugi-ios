import Combine
import SwiftUI

import Component
import Domain

public struct MainView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var appState: AppViewModel
    
    @State private var selection: Int = 0
    
    public init() {}
}

extension MainView: View {
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
