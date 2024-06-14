import SwiftUI
import WaitingJoinFeature
import Component

@main
struct WaitingJoinExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            WaitingJoinView()
        }
    }
}
