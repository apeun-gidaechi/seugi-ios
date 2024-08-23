import SwiftUI
import DIContainer
import SwiftUIUtil
import Domain
import Component

public struct RootView: View {
    
    @StateObject private var timerManager = TimerManager()
    @StateObject private var appState = AppState()
    @StateObject private var router = Router()
    @StateObject private var stompManager = StompManager()
    @StateObject private var fileManager = SeugiFileManager()
    @StateObject private var alertProvider = AlertProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    
    @StateObject private var viewModel = RootViewModel()
    
    @State private var opacity = 1.0
    
    public init() {}
    
    public var body: some View {
        SeugiModalProvider(
            alertProvider: alertProvider,
            timePickerProvider: timePickerProvider
        ) { // zstack
            NavigationStack(path: $router.navPath) {
                if appState.accessToken.isEmpty {
                    OnboardingCoordinator()
                } else {
                    MainCoordinator()
                }
            }
            
            if opacity > 0 {
                LaunchScreenView()
                    .opacity(opacity)
            }
        }
        .environmentObject(timerManager)
        .environmentObject(router)
        .environmentObject(appState)
        .environmentObject(stompManager)
        .environmentObject(fileManager)
        .onAppear {
            sleep(2)
            withAnimation {
                opacity = 0
            }
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
