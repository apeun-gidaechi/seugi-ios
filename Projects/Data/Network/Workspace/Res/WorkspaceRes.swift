import Domain

struct WorkspaceRes: Decodable, EntityMappable {
    let workspaceId: String
    let workspaceName: String
    let workspaceImageUrl: String
    let studentCount: Int
    let teacherCount: Int
    
    func toEntity() -> Workspace {
        Workspace(
            workspaceId: workspaceId,
            workspaceName: workspaceName,
            workspaceImageUrl: workspaceImageUrl,
            studentCount: studentCount,
            teacherCount: teacherCount
        )
    }
}
