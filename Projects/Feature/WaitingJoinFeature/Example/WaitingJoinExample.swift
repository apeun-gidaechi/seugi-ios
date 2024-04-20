import SwiftUI
import WaitingJoinFeature
import DesignSystem

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
