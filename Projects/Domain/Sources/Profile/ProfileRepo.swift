public protocol ProfileRepo {
    func patchProfile(
        workspaceId: String,
        status: String,
        nick: String,
        spot: String,
        belong: String,
        phone: String,
        wire: String,
        location: String
    ) -> APIResult<BaseVoid>
    func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>>
    func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>>
}
