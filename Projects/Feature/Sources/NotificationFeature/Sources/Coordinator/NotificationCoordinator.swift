import SwiftUI
import DIContainer

public struct NotificationCoordinator: View {
    
    @Inject private var postNotificationFactory: any PostNotificationFactory
    @EnvironmentObject private var notificationViewModel: NotificationViewModel
    
    public var body: some View {
        NotificationView()
            .navigationDestination(for: NotificationDestination.self) { destination in
                Group {
                    switch destination {
                    case .createNotification: postNotificationFactory.makeView(type: .createNotification).eraseToAnyView()
                    case .updateNotification(let notification): postNotificationFactory.makeView(type: .updateNotification(notification)).eraseToAnyView()
                    }
                }
                .environmentObject(notificationViewModel)
            }
    }
}
