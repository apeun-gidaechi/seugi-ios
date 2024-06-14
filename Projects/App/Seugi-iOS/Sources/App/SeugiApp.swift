import SwiftUI
import RootFeature
import BaseFeatureInterface
import Component
import Swinject
import StartFeatureInterface
import StartFeature
import DIContainer
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
            }
        }
    }
}
