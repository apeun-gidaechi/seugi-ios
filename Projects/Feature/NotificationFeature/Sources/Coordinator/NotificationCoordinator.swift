import SwiftUI
import NotificationFeatureInterface
import CreateNotificationFeatureInterface
import DIContainer

public struct NotificationCoordinator: View {
    
    @Inject private var createNotificationFactory: any CreateNotificationFactory
    
    public var body: some View {
        NotificationView()
            .navigationDestination(for: NotificationDestination.self) {
                switch $0 {
                case .createNotification: createNotificationFactory.makeView().eraseToAnyView()
                }
            }
    }
}
