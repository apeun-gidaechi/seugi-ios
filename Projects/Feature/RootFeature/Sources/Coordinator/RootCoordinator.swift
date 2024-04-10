import SwiftUI
import BaseFeatureInterface
import OnboardingFeatureInterface
import JoinSchoolFeatureInterface
import MainFeatureInterface
import DIContainerInterface
import SwiftUIUtil

public struct RootCoordinator: View {
    
    @EnvironmentObject private var appState: AppState
    @Inject private var onboardingFactory: any OnboardingFactory
    @Inject private var joinSchoolFactory: any JoinSchoolFactory
    @Inject private var mainFactory: any MainFactory
    
    public init() {}
    
    public var body: some View {
        switch appState.appFlow {
        case .unAuthorized: onboardingFactory.makeView().eraseToAnyView()
        case .notFoundJoinedSchool: joinSchoolFactory.makeView().eraseToAnyView()
        case .authorized: mainFactory.makeView().eraseToAnyView()
        }
    }
}
