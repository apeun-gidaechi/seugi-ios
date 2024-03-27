import SwiftUI
import LaunchScreenFeature
import BaseFeature

@main
struct LaunchScreenViewExample: App {
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environmentObject(NavigationController())
        }
    }
}
