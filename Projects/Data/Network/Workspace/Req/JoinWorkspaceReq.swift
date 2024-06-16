import Domain

public struct JoinWorkspaceReq: Encodable {
    let workspaceId: String
    let workspaceCode: String
    let role: WorkspaceRole
}
