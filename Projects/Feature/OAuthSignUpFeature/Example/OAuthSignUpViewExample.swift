import SwiftUI
import OAuthSignUpFeature
import BaseFeature

@main
struct OAuthSignUpViewExample: App {
    var body: some Scene {
        WindowGroup {
            OAuthSignUpView(
                navigateToRoot: {}
            )
        }
    }
}
