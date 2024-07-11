public protocol NoticeRepo {
    func getNotices(workspaceId: String) -> APIResult<Base<[Notice]>>
}
