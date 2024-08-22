import Domain
import DateUtil
import Foundation

struct NotificationRes: SeugiResponse {
    let id: Int
    let workspaceId: String
    let userId: Int
    let userName: String
    let title: String
    let content: String
    let emoji: [NotificationEmojiRes]
    let creationDate: Date
    let lastModifiedDate: Date
}

extension NotificationRes {
    func toEntity() -> Domain.Notification {
        Domain.Notification(
            id: id,
            workspaceId: workspaceId,
            userId: userId,
            userName: userName,
            title: title,
            content: content,
            emoji: emoji.map { $0.toEntity() },
            creationDate: creationDate,
            lastModifiedDate: lastModifiedDate
        )
    }
}
