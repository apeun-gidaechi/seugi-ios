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
        container.register(ChatRepo.self) { _ in
            FakeChatRepo()
        }
    }
    
    @StateObject private var appState = AppState()
    @StateObject private var vm = CreateRoomViewModel()
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                FirstCreateRoomView()
                    .navigationDestination(for: CreateRoomDestination.self) {
                        switch $0 {
                        case .secondCreateRoom: SecondCreateRoomView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(appState)
            .environmentObject(vm)
            .onAppear {
                appState.selectedWorkspace = .mock()
            }
        }
    }
}
