import SwiftUI
import Domain

struct ChatDetailCoordinator: View {
    
    // MARK: - Parameters
    private let room: Room
    
    init(
        room: Room
    ) {
        self.room = room
    }
    
    var body: some View {
        ChatDetailView(
            room: room
        )
    }
}
