import SwiftUI
import EmailSignInFeature
import BaseFeatureInterface
import Component

@main
struct EmailSignInViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            EmailSignInView(vm: .init())
        }
    }
}
