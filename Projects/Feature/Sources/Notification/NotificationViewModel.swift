import DIContainer
import Domain
import Foundation

final class NotificationViewModel: BaseViewModel<NotificationViewModel.Effect> {
    
    enum Effect {}
    
    // MARK: - Repo
    @Inject private var notificationRepo: NotificationRepo
    
    // MARK: - State
    @Published var notifications: FetchFlow<[Domain.Notification]> = .fetching
    @Published var removeNotificationFlow: IdleFlow<Bool> = .idle
    @Published var selectedNotificationForAddEmoji: Domain.Notification?
    @Published var addEmojiFlow: IdleFlow<Bool> = .idle
    
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
    
    func removeNotification(workspaceId: String, notificationId: Int) {
        sub(notificationRepo.removeNotification(workspaceId: workspaceId, id: notificationId)) {
            self.removeNotificationFlow = .fetching
        } success: { _ in
            self.removeNotificationFlow = .success()
        } failure: {
            self.removeNotificationFlow = .failure($0)
        }
    }
    
    func patchEmoji(emoji: String, workspaceId: String) {
        guard let selectedNotificationForAddEmoji else {
            return
        }
        sub(notificationRepo.emojiNotification(
            .init(emoji: emoji, notificationId: selectedNotificationForAddEmoji.id)
        )) {
            self.addEmojiFlow = .fetching
        } success: { _ in
            self.addEmojiFlow = .success()
            self.fetchNotifications(workspaceId: workspaceId)
        } failure: { err in
            self.addEmojiFlow = .failure(err)
        }
    }
}
