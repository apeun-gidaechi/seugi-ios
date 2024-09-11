public protocol ProfileRepo {
    func patchProfile(workspaceId: String, _ req: PatchProfileReq) -> ObservableResult<BaseVoid>
    func me(workspaceId: String) -> ObservableResult<Base<RetrieveProfile>>
    func others(workspaceId: String, memberId: String) -> ObservableResult<Base<RetrieveProfile>>
}
