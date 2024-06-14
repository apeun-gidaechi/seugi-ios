import SwiftUI
import CreateRoomFeature
import Component

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
