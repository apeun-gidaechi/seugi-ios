import SwiftUI
import HomeFeature
import Component

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
