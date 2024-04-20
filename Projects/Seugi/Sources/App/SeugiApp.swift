import SwiftUI
import RootFeature
import BaseFeatureInterface
import DesignSystem
import Swinject
import StartFeatureInterface
import StartFeature
import DIContainerInterface
import RootFeatureInterface
import SwiftUIUtil

@main
struct SeugiApp: App {
    
    init() {
        Pretendard.register()
        DependencyProvider.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            if let rootView = DependencyProvider.shared.container.resolve((any RootFactory).self) {
                rootView.makeView().eraseToAnyView()
                    .environmentObject(
                        AppState(
                            appFlow: .notFoundJoinedSchool,
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
                        )
                    )
                    .environmentObject(Router())
            }
        }
    }
}
