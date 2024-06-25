import NotificationFeatureInterface
import SwiftUI

final class NotificationFactoryImpl: NotificationFactory {
    func makeView() -> some View {
        NotificationCoordinator()
    }
}
