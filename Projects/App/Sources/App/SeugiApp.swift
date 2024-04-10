import SwiftUI
import RootFeature
import BaseFeature
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
                    .environmentObject(AppState(appFlow: .notFoundJoinedSchool, mainFlow: .home))
                    .environmentObject(Router())
            }   
        }
    }
}
