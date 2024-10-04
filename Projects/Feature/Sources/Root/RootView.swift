import SwiftUI
import SwiftUIUtil
import Domain

public struct RootView {
    @StateObject private var appState = AppViewModel()
    @StateObject private var router = RouterViewModel()
    @StateObject private var stompViewModel = StompViewModel()
    @StateObject private var fileViewModel = FileViewModel()
    
    public init() {}
}

extension RootView: View {
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            if appState.accessToken == nil {
                OnboardingCoordinator()
            } else {
                MainCoordinator()
            }
        }
        .launchScreen {
            LaunchScreenView()
        }
        .environmentObject(router)
        .environmentObject(appState)
        .environmentObject(stompViewModel)
        .environmentObject(fileViewModel)
        // 디버그일 경우 3번 탭할 시 세션 초기화
        #if DEBUG
        .onTapGesture(count: 3) {
            Log.info("💕 [DEBUG] MainView.body.onTapGesture - 세션이 초기화 되는 마법~")
            appState.logout()
        }
        #endif
    }
}
