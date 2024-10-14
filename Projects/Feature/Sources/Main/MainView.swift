import Combine
import SwiftUI

import Component
import Domain

public struct MainView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var stompViewModel: StompViewModel
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
        .onReceive(appState.$logoutFlow) { flow in
            if case .success = flow {
                selection = 0
                router.navigateToRoot()
            }
        }
        .onReceive(appState.$accessToken) {
            if $0 != nil {
                stompViewModel.openSocket()
            }
        }
//        .onChange(of: appState.selectedWorkspace) { _ in
//            appState.fetchWorkspaces()
//        }
        // TODO: ?. 위 코드의 의도를 파악해낼 것
    }
}
