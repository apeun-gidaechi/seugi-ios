public struct JoinWorkspaceRequest: Encodable {
    public let workspaceId: String
    public let workspaceCode: String
    public let role: WorkspaceRoleRequest
    
    public init(
        workspaceId: String,
        workspaceCode: String,
        role: WorkspaceRoleRequest
    ) {
        self.workspaceId = workspaceId
        self.workspaceCode = workspaceCode
        self.role = role
    }
}

public enum WorkspaceRoleRequest: String, RawRepresentable, Encodable {
    case STUDENT
    case TEACHER
}
