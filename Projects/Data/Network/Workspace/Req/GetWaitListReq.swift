import Domain

struct GetWaitListReq: Encodable {
    let role: WorkspaceRole
    let workspaceId: String
}
