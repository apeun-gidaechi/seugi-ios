import SwiftUI
import RootFeature
import BaseFeature

@main
struct SeugiApp: App {
    
    @StateObject var navController = NavigationController()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(navController)
        }
    }
}
