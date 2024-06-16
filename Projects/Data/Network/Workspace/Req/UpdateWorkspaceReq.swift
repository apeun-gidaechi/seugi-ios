import Domain

struct UpdateWorkspaceReq: Encodable {
    let workspaceId: String
    let workspaceName: String
    let workspaceImgUrl: String
}
