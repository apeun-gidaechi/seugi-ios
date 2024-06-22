import SwiftUI
import Component

@main
struct ComponentApp: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SeugiPreview.preview
        }
    }
}
