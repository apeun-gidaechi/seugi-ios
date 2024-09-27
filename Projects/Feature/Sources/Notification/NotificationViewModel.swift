import DIContainer
import Domain
import Foundation
import SwiftUtil

final class NotificationViewModel: BaseViewModel<NotificationViewModel.Effect> {
    
    enum Effect {}
    
    // MARK: - Repo
    @Inject private var notificationRepo: NotificationRepo
    
    // MARK: - State
    @Published var notifications: FetchFlow<[Domain.Notification]> = .fetching
    @Published var removeNotificationFlow: IdleFlow<Bool> = .idle
    @Published var selectedNotificationForAddEmoji: Domain.Notification?
    
    public func fetchNotifications(workspaceId: String) {
        notificationRepo.getNotifications(workspaceId: workspaceId).fetching {
            self.notifications = .fetching
        }.success { notifications in
            let notifications = notifications.data
                .sorted { $0.creationDate ?? .now > $1.creationDate ?? .now }
            self.notifications = .success(notifications)
        }.failure { error in
            self.notifications = .failure(error)
        }.observe(&subscriptions)
    }
    
    func removeNotification(workspaceId: String, notificationId: Int) {
        notificationRepo.removeNotification(workspaceId: workspaceId, id: notificationId).fetching {
            self.removeNotificationFlow = .fetching
        }.success { _ in
            self.removeNotificationFlow = .success()
        }.failure {
            self.removeNotificationFlow = .failure($0)
        }.observe(&subscriptions)
    }
    
    func patchEmoji(
        emoji: String,
        profileId: Int
    ) {
        guard let oldNotification = selectedNotificationForAddEmoji else { return }
        
        // 미리 Notification 이모지 업데이트
        // 빠른 UX를 위함
        var updateNotification = oldNotification
        if var clickedEmoji = updateNotification.emoji.first(where: { $0.emoji == emoji }) { // Toggle
            clickedEmoji.userList.toggle(element: profileId)
            updateNotification.emoji.replace(element: clickedEmoji) { emoji in
                emoji.emoji == clickedEmoji.emoji
            }
            if clickedEmoji.userList.isEmpty { // 유저가 없으면 이모지 자체를 삭제
                updateNotification.emoji.removeAll { $0.emoji == emoji }
            }
        } else { // Append
            updateNotification.emoji.append(.init(emoji: emoji, userList: [profileId]))
        }
        
        // Handle result
        var resultNotifications = self.notifications.data ?? []
        resultNotifications.replace(element: updateNotification) { notification in
            notification.id == updateNotification.id
        }
        self.notifications = .success(resultNotifications)
        
        // Request
        notificationRepo.emojiNotification(
            .init(emoji: emoji, notificationId: oldNotification.id)
        ).failure { _ in
            // Handle result
            // 실패 시 원래 Notification
            resultNotifications.replace(element: oldNotification) { notification in
                notification.id == oldNotification.id
            }
            self.notifications = .success(resultNotifications)
        }.observe(&subscriptions)
    }
}
