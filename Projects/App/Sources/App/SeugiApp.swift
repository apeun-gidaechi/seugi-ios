import SwiftUI
import RootFeature
import BaseFeature
import DesignSystem
import Swinject
import StartFeatureInterface
import StartFeature
import DIContainerInterface

@main
struct SeugiApp: App {
    
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

