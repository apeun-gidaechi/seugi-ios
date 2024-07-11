public protocol ProfileRepo {
    func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>>
    func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>>
}
