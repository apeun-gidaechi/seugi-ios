import SwiftUI

struct CreateRoomCoordinator: View {
    var body: some View {
        FirstCreateRoomView()
            .navigationDestination(for: CreateRoomDestination.self) {
                switch $0 {
                case .secondCreateRoom: SecondCreateRoomView()
                }
            }
    }
}
