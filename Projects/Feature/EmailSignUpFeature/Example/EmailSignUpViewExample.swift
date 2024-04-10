import SwiftUI
import EmailSignUpFeature
import BaseFeatureInterface

@main
struct EmailSignUpViewExample: App {
    var body: some Scene {
        WindowGroup {
            EmailSignUpView(vm: .init())
        }
    }
}
