public protocol NoticeRepo {
    func getNotices() -> APIResult<Base<Notice>>
}
