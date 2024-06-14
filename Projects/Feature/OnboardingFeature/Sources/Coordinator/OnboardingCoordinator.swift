import SwiftUI
import BaseFeatureInterface
import StartFeatureInterface
import EmailSignInFeatureInterface
import EmailSignUpFeatureInterface
import OAuthSignUpFeatureInterface
import SelectingJobFeatureInterface
import SwiftUIUtil
import DIContainer

public struct OnboardingCoordinator: View {
    
    @EnvironmentObject var router: Router
    @Inject private var startFactory: any StartFactory
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            startFactory.makeView().eraseToAnyView()
        }
    }
}
