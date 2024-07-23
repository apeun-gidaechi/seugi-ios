import Domain

public struct UpdateWorkspaceReq: Encodable {
    let workspaceId: String
    let workspaceName: String
    let workspaceImgUrl: String
}
