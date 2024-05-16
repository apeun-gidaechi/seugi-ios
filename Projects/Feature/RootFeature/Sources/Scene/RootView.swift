import SwiftUI
import BaseFeatureInterface
import OnboardingFeatureInterface
import JoinSchoolFeatureInterface
import MainFeatureInterface
import DIContainerInterface
import SwiftUIUtil
import UserDefaultInterface

public struct RootView: View {
    
    @StateObject private var timerManager = TimerManager()
    @StateObject private var appState: AppState
    @StateObject private var router = Router()
    @StateObject private var joinWorkspaceManager = JoinWorkspaceManager()
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
        VStack {
            switch appState.appFlow {
            case .unAuthorized: onboardingFactory.makeView().eraseToAnyView()
                    .environmentObject(timerManager)
            case .notFoundJoinedSchool: joinSchoolFactory.makeView().eraseToAnyView()
            case .authorized: mainFactory.makeView().eraseToAnyView()
            }
        }
        .environmentObject(joinWorkspaceManager)
        .environmentObject(appState)
        .environmentObject(router)
        .task {
//            appState.setAccessToken(with: "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJyaGVlc2V1bGFAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlhdCI6MTcxNTg1Mzg3MiwiZXhwIjoxNzE1ODU5ODcyfQ.P2PcacXOH2yH7CWQ9ZQsSJzlOQqJOnN6Pt5Yi7jVyh4")
//            appState.setRefreshToken(with: "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OSwiZW1haWwiOiJyaGVlc2V1bGFAZ21haWwuY29tIiwicm9sZSI6IlJPTEVfVVNFUiIsImlhdCI6MTcxNTg1Mzg3MiwiZXhwIjoxNzE1ODU1NjcyfQ.Gl-gtWINaiK6tGeAGDjbOwij_Tpm8fdPA64_upFcbxQ")
            await appState.fetchWorkspaces()
        }
    }
}
