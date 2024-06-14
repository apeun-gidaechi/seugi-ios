import SwiftUI
import ChatDetailFeature
import Component

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
