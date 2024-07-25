import SwiftUI
import Component

@main
struct ComponentApp: App {
    
    init() {
        Pretendard.register()
    }
    @State var opacity = 1.0
    @StateObject var a = AlertProvider()
    @StateObject var t = TimePickerProvider()
    
    var body: some Scene {
        WindowGroup {
            SeugiModalProvider(alertProvider: a, timePickerProvider: t) {
                NavigationStack {
                    SeugiPreview.preview
                }
            }
        }
    }
}
