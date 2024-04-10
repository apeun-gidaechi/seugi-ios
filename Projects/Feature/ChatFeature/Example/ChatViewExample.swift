import SwiftUI
import ChatFeature
import DesignSystem

@main
struct ChatViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ChatView {}
            }
        }
    }
}
