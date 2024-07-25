import SwiftUI
import PostNotificationFeatureInterface

final class PostNotificationFactoryImpl: PostNotificationFactory {
    func makeView(type: PostNotificationType) -> some View {
        PostNotificationCoordinator(
            type: type
        )
    }
}

