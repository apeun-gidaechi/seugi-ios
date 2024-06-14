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
    @StateObject private var appState: AppState
    @StateObject private var router = Router()
    @StateObject private var joinWorkspaceManager = JoinWorkspaceManager()
    @Inject private var onboardingFactory: any OnboardingFactory
    @Inject private var joinSchoolFactory: any JoinSchoolFactory
    @Inject private var launchScreenFactorry: any LaunchScreenFactory
    @Inject private var mainFactory: any MainFactory
    @InjectObject private var viewModel: RootViewModel
    @State private var opacity = 1.0
    
    public init() {
        self._appState = StateObject(wrappedValue: .init(
            mainFlow: .init(
                cellData: [
                    .init(type: .home, hasBadge: false),
                    .init(type: .chat, hasBadge: false),
                    .init(type: .room, hasBadge: false),
                    .init(type: .notification, hasBadge: false),
                    .init(type: .profile, hasBadge: false)
                ],
                selectedTab: .home
            )
        ))
    }
    
    public var body: some View {
        ZStack {
            VStack {
                switch appState.appFlow {
                case .unAuthorized: onboardingFactory.makeView().eraseToAnyView()
                        .environmentObject(timerManager)
                case .notFoundJoinedSchool: joinSchoolFactory.makeView().eraseToAnyView()
                        .environmentObject(joinWorkspaceManager)
                case .authorized: mainFactory.makeView().eraseToAnyView()
                }
            }
            launchScreenFactorry.makeView().eraseToAnyView()
                .opacity(opacity)
        }
        .environmentObject(appState)
        .environmentObject(router)
        .task {
            await appState.fetchWorkspaces()
            router.navigateToRoot()
            sleep(2)
            withAnimation {
                opacity = 0
            }
        }
    }
}
