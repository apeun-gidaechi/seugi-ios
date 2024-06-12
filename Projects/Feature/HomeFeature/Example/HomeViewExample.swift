import SwiftUI
import HomeFeature
import DesignSystem

@main
struct HomeViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
