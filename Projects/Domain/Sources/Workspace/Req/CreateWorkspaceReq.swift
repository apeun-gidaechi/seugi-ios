import SwiftBok

@Init()
@Members()
public struct CreateWorkspaceReq: Encodable {
    public let workspaceName: String
    public let workspaceImageUrl: String
}
