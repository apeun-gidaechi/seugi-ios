import SwiftUI
import BaseFeatureInterface
import OnboardingFeatureInterface
import JoinSchoolFeatureInterface
import MainFeatureInterface
import DIContainer
import SwiftUIUtil
import Domain
import LaunchScreenFeatureInterface

public struct RootView: View {
    
    @StateObject private var timerManager = TimerManager()
    @StateObject private var appState = AppState()
    @StateObject private var router = Router()
    @StateObject private var joinWorkspaceManager = JoinWorkspaceManager()
    @Inject private var onboardingFactory: any OnboardingFactory
    @Inject private var joinSchoolFactory: any JoinSchoolFactory
    @Inject private var launchScreenFactorry: any LaunchScreenFactory
    @Inject private var mainFactory: any MainFactory
    @InjectObject private var viewModel: RootViewModel
    @State private var opacity = 1.0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            if opacity == 0 {
                VStack {
                    switch appState.appFlow {
                    case .unAuthorized: onboardingFactory.makeView().eraseToAnyView()
                            .environmentObject(timerManager)
                    case .notFoundJoinedSchool: joinSchoolFactory.makeView().eraseToAnyView()
                            .environmentObject(joinWorkspaceManager)
                    case .authorized: mainFactory.makeView().eraseToAnyView()
                    }
                }
            }
            launchScreenFactorry.makeView().eraseToAnyView()
                .opacity(opacity)
        }
        .environmentObject(appState)
        .environmentObject(router)
        .onAppear {
            appState.subscribe { [self] subject in
                switch subject {
                case .fetchWorkspaceSuccess:
                    router.navigateToRoot()
                    sleep(2)
                    withAnimation {
                        opacity = 0
                    }
                }
            }
            appState.fetchWorkspaces()
        }
    }
}
