import SwiftUI
import DIContainer

public struct NotificationCoordinator: View {
    
    @EnvironmentObject private var notificationViewModel: NotificationViewModel
    
    public var body: some View {
        NotificationView()
            .navigationDestination(for: NotificationDestination.self) { destination in
                Group {
                    switch destination {
                    case .createNotification: PostNotificationCoordinator(type: .createNotification)
                    case .updateNotification(let notification): PostNotificationCoordinator(type: .updateNotification(notification))
                    }
                }
                .environmentObject(notificationViewModel)
            }
    }
}
