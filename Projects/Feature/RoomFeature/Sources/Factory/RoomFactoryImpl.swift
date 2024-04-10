import SwiftUI
import RoomFeatureInterface

final class RoomFactoryImpl: RoomFactory {
    func makeView() -> some View {
        RoomCoordinator()
    }
}
