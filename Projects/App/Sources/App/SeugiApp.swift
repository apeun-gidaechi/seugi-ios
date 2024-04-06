import SwiftUI
import RootFeature
import BaseFeature
import DesignSystem

@main
struct SeugiApp: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
