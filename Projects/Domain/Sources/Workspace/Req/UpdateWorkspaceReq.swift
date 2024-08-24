import SwiftBok

@Init()
@Members()
public struct UpdateWorkspaceReq: Encodable {
    public let workspaceId: String
    public let workspaceName: String
    public let workspaceImgUrl: String
}
