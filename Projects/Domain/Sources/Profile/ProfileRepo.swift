public protocol ProfileRepo {
    func patchProfile(workspaceId: String, _ req: PatchProfileReq) -> APIResult<BaseVoid>
    func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>>
    func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>>
}
