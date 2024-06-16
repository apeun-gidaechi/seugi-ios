import Domain

struct WaitSetWorkspaceMemberReq: Encodable {
    let workspaceId: String
    let approvalUserSet: [Int]
    let role: WorkspaceRole
}
