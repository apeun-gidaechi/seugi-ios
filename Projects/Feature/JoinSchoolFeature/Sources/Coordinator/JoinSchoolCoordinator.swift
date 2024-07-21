import SwiftUI
import BaseFeatureInterface
import DIContainer
import SwiftUIUtil

public struct JoinSchoolCoordinator: View {
    
    @EnvironmentObject private var router: Router
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.navPath) {
            SchoolCodeView()
        }
    }
}
