import SwiftUI
import CreateRoomFeature
import DesignSystem

@main
struct CreateRoomViewExample: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            FirstCreateRoomView()
        }
    }
}
