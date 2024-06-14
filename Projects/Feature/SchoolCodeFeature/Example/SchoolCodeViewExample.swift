import SwiftUI
import SchoolCodeFeature
import Component

@main
struct SchoolCodeViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            SchoolCodeView(vm: .init())
        }
    }
}
