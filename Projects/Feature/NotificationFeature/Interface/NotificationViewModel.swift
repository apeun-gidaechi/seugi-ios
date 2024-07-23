import DIContainer
import Domain
import BaseFeatureInterface
import Foundation

public final class NotificationViewModel: BaseViewModel<NotificationViewModel.NotificationSubject> {
    
    public enum NotificationSubject {}
    
    // MARK: - Repo
    @Inject private var noticeRepo: NotificationRepo
    
    // MARK: - State
    @Published public var notices: FetchFlow<[Domain.Notification]> = .fetching
    
    public func fetchNotices(workspaceId: String) {
        sub(noticeRepo.getNotifications(workspaceId: workspaceId)) {
            self.notices = .fetching
        } success: { notices in
            self.notices = .success(notices.data)
        } failure: { error in
            self.notices = .failure(error)
        }
    }
}
