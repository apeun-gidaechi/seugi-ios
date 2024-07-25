import SwiftUI
import BaseFeatureInterface
import OnboardingFeatureInterface
import JoinWorkspaceFeatureInterface
import MainFeatureInterface
import DIContainer
import SwiftUIUtil
import Domain
import LaunchScreenFeatureInterface
import Component

public struct RootView: View {
    
    @StateObject private var timerManager = TimerManager()
    @StateObject private var appState = AppState()
    @StateObject private var router = Router()
    @StateObject private var stompManager = StompManager()
    @StateObject private var fileManager = SeugiFileManager()
    @StateObject private var alertProvider = AlertProvider()
    @Inject private var onboardingFactory: any OnboardingFactory
    @Inject private var joinWorkspaceFactory: any JoinWorkspaceFactory
    @Inject private var launchScreenFactorry: any LaunchScreenFactory
    @Inject private var mainFactory: any MainFactory
    @InjectObject private var viewModel: RootViewModel
    @State private var opacity = 1.0
    @State private var alertBackgroundOpacity = 0.0
    
    public init() {}
    
    public var body: some View {
        SeugiAlertPresenter(provider: alertProvider, backgroundOpacity: $alertBackgroundOpacity) {
            NavigationStack(path: $router.navPath) {
                if appState.accessToken.isEmpty {
                    onboardingFactory.makeView().eraseToAnyView()
                        .environmentObject(timerManager)
                } else {
                    mainFactory.makeView().eraseToAnyView()
                }
            }
        
            if opacity > 0 {
                launchScreenFactorry.makeView().eraseToAnyView()
                    .opacity(opacity)
            }
            
            Color.black.opacity(0.2).ignoresSafeArea()
                .opacity(alertBackgroundOpacity)
        }
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
            print("💕 [DEBUG] MainView.body.onTapGesture - 세션이 초기화 되는 마법~")
            appState.logout()
        }
        #endif
    }
}
