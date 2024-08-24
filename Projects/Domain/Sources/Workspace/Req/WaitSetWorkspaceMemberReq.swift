import Foundation
import SwiftBok

@Init()
@Members()
public struct WaitSetWorkspaceMemberReq: Encodable {
    public let workspaceId: String
    public let userSet: [Int]
    public let role: WorkspaceRole
}
