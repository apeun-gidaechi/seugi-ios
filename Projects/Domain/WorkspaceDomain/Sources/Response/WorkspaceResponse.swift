import WorkspaceDomainInterface

struct WorkspaceResponse: Decodable {
    let workspaceId: String
    let workspaceName: String
    let workspaceImageUrl: String
    let studentCount: Int
    let teacherCount: Int
    
    func toDomain() -> Workspace {
        Workspace(workspaceId: workspaceId,
                  workspaceName: workspaceName, workspaceImageUrl: workspaceImageUrl, studentCount: studentCount, teacherCount: teacherCount)
    }
}
