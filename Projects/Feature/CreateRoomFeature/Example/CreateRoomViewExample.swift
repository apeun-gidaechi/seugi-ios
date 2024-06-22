import SwiftUI
import CreateRoomFeature
import Component
import DIContainer
import BaseFeatureInterface
import Domain
import DomainTesting

@main
struct CreateRoomViewExample: App {
    
    init() {
        Pretendard.register()
        let container = DependencyProvider.shared.container
        container.register(WorkspaceRepo.self) { _ in
            FakeWorkspaceRepo()
        }
        container.register(KeyValueRepo.self) { _ in
            FakeKeyValueRepo()
        }
    }
    
    @StateObject private var appState = AppState()
    @StateObject private var vm = CreateRoomViewModel()
    
    var body: some Scene {
        WindowGroup {
            FirstCreateRoomView()
                .environmentObject(Router())
                .environmentObject(appState)
                .environmentObject(vm)
                .onAppear {
                    appState.selectedWorkspace = .mock()
                }
        }
    }
}
