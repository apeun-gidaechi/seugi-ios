import SwiftUI
import Component

@main
struct ComponentApp: App {
    
    init() {
        Pretendard.register()
    }
    @State var opacity = 0.0
    
    var body: some Scene {
        WindowGroup {
            SeugiModalProvider {
                SeugiPreview.preview
            }
        }
    }
}
