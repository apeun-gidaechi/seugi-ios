import SwiftUI
import StartFeature
import BaseFeature
import DesignSystem

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
