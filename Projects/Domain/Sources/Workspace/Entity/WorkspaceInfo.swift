public struct WorkspaceInfo: Entity, Equatable {
    public let workspaceId: String
    public let workspaceName: String
    public let workspaceImageUrl: String
    public let studentCount: Int
    public let teacherCount: Int
    
    public init(workspaceId: String, workspaceName: String, workspaceImageUrl: String, studentCount: Int, teacherCount: Int) {
        self.workspaceId = workspaceId
        self.workspaceName = workspaceName
        self.workspaceImageUrl = workspaceImageUrl
        self.studentCount = studentCount
        self.teacherCount = teacherCount
    }
}
