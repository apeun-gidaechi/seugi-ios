import SwiftUI
import MainFeature
import BaseFeature

@main
struct MainViewExample: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(NavigationController())
        }
    }
}
