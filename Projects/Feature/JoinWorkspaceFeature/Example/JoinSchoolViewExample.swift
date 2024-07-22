import SwiftUI
import JoinWorkspaceFeature
import BaseFeatureInterface
import Component
import DIContainer
import Domain
import DomainTesting

@main
struct JoinSchoolViewExample: App {
    
    init() {
        Pretendard.register()
        let d = DependencyProvider.shared.container
        d.register((any WorkspaceRepo).self) { _ in
            FakeWorkspaceRepo()
        }
    }
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                JoinSchoolCoordinator()
            }
            .environmentObject(router)
        }
    }
}
