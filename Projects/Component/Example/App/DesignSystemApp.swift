import SwiftUI
import Component

@main
struct DesignSystemApp: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SeugiPreview.preview
        }
    }
}
