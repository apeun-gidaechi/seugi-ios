import PublicInit

@PublicInit
public struct Workspace: Entity, Equatable {
    public let workspaceId: String
    public let workspaceName: String
    public let workspaceImageUrl: String
    public let studentCount: Int
    public let teacherCount: Int
}
