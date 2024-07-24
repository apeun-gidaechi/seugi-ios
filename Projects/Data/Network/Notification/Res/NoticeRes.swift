import Domain
import DateUtil
import Foundation

struct NoticeRes: SeugiResponse {
    let id: Int
    let workspaceId: String
    let userName: String
    let title: String
    let content: String
    let emoji: [String]
    let creationDate: Date
    let lastModifiedDate: Date
}

extension NoticeRes {
    func toEntity() -> Domain.Notification {
        Domain.Notification(
            id: id,
            workspaceId: workspaceId,
            userName: userName,
            title: title,
            content: content,
            emoji: emoji,
            creationDate: creationDate,
            lastModifiedDate: lastModifiedDate
        )
    }
}
