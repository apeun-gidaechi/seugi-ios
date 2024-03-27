import SwiftUI
import EmailSignInFeature
import BaseFeature

@main
struct EmailSignInViewExample: App {
    
    var body: some Scene {
        WindowGroup {
            EmailSignInView()
                .environmentObject(NavigationController())
        }
    }
}
