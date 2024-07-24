import SwiftUI
import SettingWorkspaceFeature
import BaseFeatureInterface
import DIContainer
import Domain
import DomainTesting
import Component

@main
struct SettingWorkspaceExample: App {
    
    init() {
        Pretendard.register()
        let d = DependencyProvider.shared.container
        d.register((any KeyValueRepo).self) { _ in
            FakeKeyValueRepo()
        }
        d.register((any WorkspaceRepo).self) { _ in
            FakeWorkspaceRepo()
        }
        d.register((any ProfileRepo).self) { _ in
            FakeProfileRepo()
        }
    }
    
    @StateObject private var router = Router()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                SettingWorkspaceCoordinator()
            }
            .environmentObject(router)
            .environmentObject(appState)
            .onAppear {
                appState.selectedWorkspace = .mock()
            }
        }
    }
}
