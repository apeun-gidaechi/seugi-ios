import SwiftUI
import ChatDetailFeature
import Component
import DomainTesting
import DIContainer
import Domain
import BaseFeatureInterface

@main
struct ChatDetailViewExample: App {
    
    init() {
        Pretendard.register()
        let d = DependencyProvider.shared.container
        d.register(ChatDetailViewModel.self) { _ in
            ChatDetailViewModel()
        }
        d.register((any MessageRepo).self) { _ in
            FakeMessageRepo()
        }
        d.register((any ChatRepo).self) { _ in
            FakeChatRepo()
        }
        d.register((any StompRepo).self) { _ in
            FakeStompRepo()
        }
        d.register((any FileRepo).self) { _ in
            FakeFileRepo()
        }
        d.register((any StompMessageRepo).self) { _ in
            FakeStompMessageRepo()
        }
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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ChatDetailView(room: .mock())
            }
            .environmentObject(Router())
            .environmentObject(AppState())
        }
    }
}
