import DIContainer
import Domain
import BaseFeatureInterface
import Foundation

public final class NotificationViewModel: BaseViewModel<NotificationViewModel.NotificationSubject> {
    
    public enum NotificationSubject {}
    
    // MARK: - Repo
    @Inject private var noticeRepo: NotificationRepo
    
    // MARK: - State
    @Published public var notifications: FetchFlow<[Domain.Notification]> = .fetching
    
    public func fetchNotifications(workspaceId: String) {
        sub(noticeRepo.getNotifications(workspaceId: workspaceId)) {
            self.notifications = .fetching
        } success: { notifications in
            let notifications = notifications.data
                .sorted { $0.creationDate ?? .now > $1.creationDate ?? .now }
            self.notifications = .success(notifications)
        } failure: { error in
            self.notifications = .failure(error)
        }
    }
}
