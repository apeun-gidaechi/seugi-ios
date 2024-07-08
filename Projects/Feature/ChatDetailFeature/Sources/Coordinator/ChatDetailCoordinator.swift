import SwiftUI
import Domain

struct ChatDetailCoordinator: View {
    
    private let room: Room
    
    init(room: Room) {
        self.room = room
    }
    
    var body: some View {
        ChatDetailView(room: room)
    }
}
