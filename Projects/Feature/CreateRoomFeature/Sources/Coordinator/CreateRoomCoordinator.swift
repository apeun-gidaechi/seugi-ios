import SwiftUI
import DIContainer

struct CreateRoomCoordinator: View {
    @InjectObject private var createRoomViewModel: CreateRoomViewModel
    var body: some View {
        FirstCreateRoomView()
            .navigationDestination(for: CreateRoomDestination.self) {
                switch $0 {
                case .secondCreateRoom: SecondCreateRoomView()
                }
            }
            .environmentObject(createRoomViewModel)
    }
}
