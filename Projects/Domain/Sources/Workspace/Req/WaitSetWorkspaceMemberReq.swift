public struct WaitSetWorkspaceMemberReq: Encodable {
    public let workspaceId: String
    public let userSet: [Int]
    public let role: WorkspaceRole
    
    public init(workspaceId: String, userSet: [Int], role: WorkspaceRole) {
        self.workspaceId = workspaceId
        self.userSet = userSet
        self.role = role
    }
}
