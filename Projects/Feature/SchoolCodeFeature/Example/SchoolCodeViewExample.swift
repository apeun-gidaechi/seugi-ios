import SwiftUI
import SchoolCodeFeature
import DesignSystem

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
