import DIContainer
import Domain
import Foundation
import SwiftUtil

final class NotificationViewModel: BaseViewModel<NotificationViewModel.Effect> {
    
    enum Effect {}
    
    // MARK: - Repo
    @Inject private var notificationRepo: NotificationRepo
    
    // MARK: - State
    @Published var notifications: Flow<[Domain.Notification]> = .fetching
    @Published var removeNotificationFlow: Flow<Bool> = .idle
    @Published var selectedNotificationForAddEmoji: Domain.Notification?
    
    public func fetchNotifications(workspaceId: String) {
        notificationRepo.getNotifications(workspaceId: workspaceId)
            .map { $0.data.sorted { $0.creationDate ?? .now > $1.creationDate ?? .now } }
            .flow(\.notifications, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func removeNotification(workspaceId: String, notificationId: Int) {
        notificationRepo.removeNotification(
            workspaceId: workspaceId,
            id: notificationId
        )
        .map { _ in true }
        .flow(\.removeNotificationFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
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
        )
        .sink { _ in
            if case .failure = self.notifications {
                resultNotifications.replace(element: oldNotification) { notification in
                    notification.id == oldNotification.id
                }
                self.notifications = .success(resultNotifications)
            }
        } receiveValue: { _ in
        }
        .store(in: &subscriptions)
    }
}
