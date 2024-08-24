import SwiftBok

@Init()
@Members()
public struct JoinWorkspaceReq: Encodable {
    public let workspaceId: String
    public let workspaceCode: String
    public let role: WorkspaceRole
}
