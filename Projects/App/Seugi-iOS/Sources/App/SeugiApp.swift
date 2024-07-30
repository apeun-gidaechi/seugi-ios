import SwiftUI
import BaseFeatureInterface
import Component
import Swinject
import DIContainer
import RootFeatureInterface
import SwiftUIUtil

@main
struct SeugiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
