public struct JoinWorkspaceRequest: Encodable {
    public let workspaceId: String
    public let workspaceCode: String
    public let role: WorkspaceRoleType
    
    public init(
        workspaceId: String,
        workspaceCode: String,
        role: WorkspaceRoleType
    ) {
        self.workspaceId = workspaceId
        self.workspaceCode = workspaceCode
        self.role = role
    }
}

public enum WorkspaceRoleType: String, RawRepresentable, Encodable {
    case STUDENT
    case TEACHER
}
