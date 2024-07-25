import SwiftUI
import UpdateNotificationFeatureInterface

final class UpdateNotificationFactoryImpl: UpdateNotificationFactory {
    func makeView(id: Int) -> some View {
        UpdateNotificationCoordinator(id: id)
    }
}

