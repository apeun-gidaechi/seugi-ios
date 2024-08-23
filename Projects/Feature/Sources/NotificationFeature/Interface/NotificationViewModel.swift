import DIContainer
import Domain
import Foundation

public final class NotificationViewModel: BaseViewModel<NotificationViewModel.NotificationSubject> {
    
    public enum NotificationSubject {}
    
    // MARK: - Repo
    @Inject private var notificationRepo: NotificationRepo
    
    // MARK: - State
    @Published public var notifications: FetchFlow<[Domain.Notification]> = .fetching
    @Published public var removeNotificationFlow: IdleFlow<Bool> = .idle
    
    public func fetchNotifications(workspaceId: String) {
        sub(notificationRepo.getNotifications(workspaceId: workspaceId)) {
            self.notifications = .fetching
        } success: { notifications in
            let notifications = notifications.data
                .sorted { $0.creationDate ?? .now > $1.creationDate ?? .now }
            self.notifications = .success(notifications)
        } failure: { error in
            self.notifications = .failure(error)
        }
    }
    
    public func removeNotification(workspaceId: String, notificationId: Int) {
        sub(notificationRepo.removeNotification(workspaceId: workspaceId, id: notificationId)) {
            self.removeNotificationFlow = .fetching
        } success: { _ in
            self.removeNotificationFlow = .success()
        } failure: {
            self.removeNotificationFlow = .failure($0)
        }
    }
}
