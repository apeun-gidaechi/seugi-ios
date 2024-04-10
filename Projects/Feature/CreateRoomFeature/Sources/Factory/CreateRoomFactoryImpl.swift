import SwiftUI
import CreateRoomFeatureInterface

final class CreateRoomFactoryImpl: CreateRoomFactory {
    func makeView() -> some View {
        CreateRoomCoordinator()
    }
}
