import Domain

final class NoticeService: Service<NoticeEndpoint>, NoticeRepo {
    func getNotices(workspaceId: String) -> APIResult<Base<[Notice]>> {
        performRequest(.getNotices(workspaceId: workspaceId), res: [NoticeRes].self)
    }
}
