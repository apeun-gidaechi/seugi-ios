public struct JoinWorkspaceReq: Encodable {
    public let workspaceId: String
    public let workspaceCode: String
    public let role: WorkspaceRole
    
    public init(workspaceId: String, workspaceCode: String, role: WorkspaceRole) {
        self.workspaceId = workspaceId
        self.workspaceCode = workspaceCode
        self.role = role
    }
}
