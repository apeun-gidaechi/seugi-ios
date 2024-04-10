import SwiftUI
import EmailSignUpFeature
import BaseFeature

@main
struct EmailSignUpViewExample: App {
    var body: some Scene {
        WindowGroup {
            EmailSignUpView(vm: .init())
        }
    }
}
