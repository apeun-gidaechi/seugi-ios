import Combine
import WidgetKit
import SwiftUI

import Component
import Domain

struct MainView {
    @EnvironmentObject private var router: RouterViewModel
    @EnvironmentObject private var stompViewModel: StompViewModel
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    @AppStorage("ACCESS_TOKEN", store: .seugi) private var accessToken: String?
    
    @State private var selection: Int = 0
}

extension MainView: View {
    var body: some View {
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
        .onChange(of: mainViewModel.selectedWorkspace) { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        .onChange(of: accessToken) { accessToken in
            if let accessToken {
                stompViewModel.reissue(accessToken: accessToken)
            }
        }
    }
}
