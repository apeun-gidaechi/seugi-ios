import SwiftUI
import NotificationFeatureInterface
import CreateNotificationFeatureInterface
import UpdateNotificationFeatureInterface
import DIContainer

public struct NotificationCoordinator: View {
    
    @Inject private var createNotificationFactory: any CreateNotificationFactory
    @Inject private var updateNotificationFactory: any UpdateNotificationFactory
    
    public var body: some View {
        NotificationView()
            .navigationDestination(for: NotificationDestination.self) {
                switch $0 {
                case .createNotification: createNotificationFactory.makeView().eraseToAnyView()
                case .updateNotification(let id): updateNotificationFactory.makeView(id: id).eraseToAnyView()
                }
            }
    }
}
