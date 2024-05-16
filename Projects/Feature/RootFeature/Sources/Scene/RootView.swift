import SwiftUI
import BaseFeatureInterface
import OnboardingFeatureInterface
import JoinSchoolFeatureInterface
import MainFeatureInterface
import DIContainerInterface
import SwiftUIUtil
import UserDefaultInterface

public struct RootView: View {
    
    @StateObject private var appState: AppState
    @Inject private var onboardingFactory: any OnboardingFactory
    @Inject private var joinSchoolFactory: any JoinSchoolFactory
    @Inject private var mainFactory: any MainFactory
    @InjectObject private var viewModel: RootViewModel
    
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
        Group {
            switch appState.appFlow {
            case .unAuthorized: onboardingFactory.makeView().eraseToAnyView()
            case .notFoundJoinedSchool: joinSchoolFactory.makeView().eraseToAnyView()
            case .authorized: mainFactory.makeView().eraseToAnyView()
            }
        }
        .environmentObject(appState)
        .environmentObject(Router())
        .task {
            await appState.fetchWorkspaces()
        }
    }
}
