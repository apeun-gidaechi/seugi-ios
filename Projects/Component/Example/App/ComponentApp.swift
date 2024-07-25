import SwiftUI
import Component

@main
struct ComponentApp: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SeugiAlertPresenter {
                SeugiPreview.preview
            }
        }
    }
}
