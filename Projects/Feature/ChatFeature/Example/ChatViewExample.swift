import SwiftUI
import ChatFeature
import Component

@main
struct ChatViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ChatView(roomType: .personal)
        }
    }
}
