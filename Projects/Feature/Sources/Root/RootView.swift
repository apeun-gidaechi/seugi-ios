import SwiftUI
import DIContainer
import SwiftUIUtil
import Domain
import Component

public struct RootView: View {
    
    @StateObject private var timerManager = TimerManager()
    @StateObject private var appState = AppObservable()
    @StateObject private var router = RouterObservable()
    @StateObject private var stompManager = StompManager()
    @StateObject private var fileManager = FileManager()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            if appState.accessToken.isEmpty {
                OnboardingCoordinator()
            } else {
                MainCoordinator()
            }
        }
        .launchScreen {
            LaunchScreenView()
        }
        .environmentObject(timerManager)
        .environmentObject(router)
        .environmentObject(appState)
        .environmentObject(stompManager)
        .environmentObject(fileManager)
        .onAppear {
            appState.subscribe { subject in
                switch subject {
                case .logout:
                    router.navigateToRoot()
                default:
                    break
                }
            }
        }
        // 디버그일 경우 3번 탭할 시 세션 초기화
        #if DEBUG
        .onTapGesture(count: 3) {
            log("💕 [DEBUG] MainView.body.onTapGesture - 세션이 초기화 되는 마법~")
            appState.logout()
        }
        #endif
    }
}
