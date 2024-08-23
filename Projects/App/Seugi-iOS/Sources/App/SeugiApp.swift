import SwiftUI
import Component
import Swinject
import DIContainer
import SwiftUIUtil
import Feature

@main
struct SeugiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        Pretendard.register()
        DependencyProvider.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
