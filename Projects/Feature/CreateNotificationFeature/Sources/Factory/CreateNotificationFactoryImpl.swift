import SwiftUI
import CreateNotificationFeatureInterface

final class CreateNotificationFactoryImpl: CreateNotificationFactory {
    func makeView() -> some View {
        CreateNotificationCoordinator()
    }
}

