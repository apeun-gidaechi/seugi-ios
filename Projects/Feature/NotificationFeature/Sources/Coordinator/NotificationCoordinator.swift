import SwiftUI
import NotificationFeatureInterface
import PostNotificationFeatureInterface
import DIContainer

public struct NotificationCoordinator: View {
    
    @Inject private var postNotificationFactory: any PostNotificationFactory
    
    public var body: some View {
        NotificationView()
            .navigationDestination(for: NotificationDestination.self) {
                switch $0 {
                case .createNotification: postNotificationFactory.makeView(type: .createNotification).eraseToAnyView()
                case .updateNotification(let notification): postNotificationFactory.makeView(type: .updateNotification(notification)).eraseToAnyView()
                }
            }
    }
}
