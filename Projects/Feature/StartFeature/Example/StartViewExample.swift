import SwiftUI
import StartFeature
import BaseFeatureInterface
import Component

@main
struct StartViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(Router())
        }
    }
}
