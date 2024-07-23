import Domain
import DateUtil

struct NoticeRes: SeugiResponse {
    let id: Int
    let workspaceId: String
    let userName: String
    let title: String
    let content: String
    let emoji: [String]
    let creationDate: String
    let lastModifiedDate: String
}

extension NoticeRes {
    func toEntity() -> Notification {
        Notification(
            id: id,
            workspaceId: workspaceId,
            userName: userName,
            title: title,
            content: content,
            emoji: emoji,
            creationDate: creationDate.localDateTime,
            lastModifiedDate: lastModifiedDate.localDateTime
        )
    }
}
