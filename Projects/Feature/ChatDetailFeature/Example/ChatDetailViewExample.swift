import SwiftUI
import ChatDetailFeature
import DesignSystem

@main
struct ChatDetailViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ChatDetailView()
        }
    }
}
