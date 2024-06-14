import SwiftUI
import BaseFeatureInterface
import SchoolCodeFeatureInterface
import JoinSuccessFeatureInterface
import DIContainer
import SwiftUIUtil

public struct JoinSchoolCoordinator: View {
    
    @EnvironmentObject private var router: Router
    @Inject private var schoolCodeFactory: any SchoolCodeFactory
    @Inject private var joinSuccessFactory: any JoinSuccessFactory
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            schoolCodeFactory.makeView().eraseToAnyView()
        }
    }
}
