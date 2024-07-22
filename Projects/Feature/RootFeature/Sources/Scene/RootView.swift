import SwiftUI
import BaseFeatureInterface
import OnboardingFeatureInterface
import JoinWorkspaceFeatureInterface
import MainFeatureInterface
import DIContainer
import SwiftUIUtil
import Domain
import LaunchScreenFeatureInterface

public struct RootView: View {
    
    @StateObject private var timerManager = TimerManager()
    @StateObject private var appState = AppState()
    @StateObject private var router = Router()
    @StateObject private var stompManager = StompManager()
    @Inject private var onboardingFactory: any OnboardingFactory
    @Inject private var joinSchoolFactory: any JoinSchoolFactory
    @Inject private var launchScreenFactorry: any LaunchScreenFactory
    @Inject private var mainFactory: any MainFactory
    @InjectObject private var viewModel: RootViewModel
    @State private var opacity = 1.0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            if appState.accessToken.isEmpty {
                onboardingFactory.makeView().eraseToAnyView()
                    .environmentObject(timerManager)
            } else {
                mainFactory.makeView().eraseToAnyView()
            }
            if opacity > 0 {
                launchScreenFactorry.makeView().eraseToAnyView()
                    .opacity(opacity)
            }
        }
        .environmentObject(router)
        .environmentObject(appState)
        .environmentObject(stompManager)
        .onAppear {
            sleep(2)
            withAnimation {
                opacity = 0
            }
        }
        // 디버그일 경우 3번 탭할 시 세션 초기화
        #if DEBUG
        .onTapGesture(count: 3) {
            print("💕 MainView.body.onTapGesture - 세션 초기화")
            withAnimation {
                appState.token = .init(accessToken: "", refreshToken: "")
            }
        }
        #endif
    }
}
