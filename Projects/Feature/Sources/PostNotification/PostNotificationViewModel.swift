import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

class PostNotificationViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var notificationRepo: NotificationRepo
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var postNotificationFlow: Flow<BaseVoid> = .idle
    @Published var removeNotificationFlow: Flow<BaseVoid> = .idle
    
    var isValidInput: Bool {
        !title.isEmpty && !content.isEmpty
    }
    
    func createNotification(workspaceId: String) {
        notificationRepo.postNotification(
            .init(
                title: title,
                content: content,
                workspaceId: workspaceId
            )
        )
        .flow(\.postNotificationFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func updateNotification(notificationId: Int) {
        notificationRepo.updateNotification(
            .init(
                id: notificationId,
                title: title,
                content: content
            )
        )
        .flow(\.postNotificationFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func removeNotification(workspaceId: String, notificationId: Int) {
        notificationRepo.removeNotification(
            workspaceId: workspaceId,
            id: notificationId
        )
        .flow(\.removeNotificationFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
