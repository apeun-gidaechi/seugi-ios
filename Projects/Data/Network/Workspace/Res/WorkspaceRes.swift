import Domain

struct WorkspaceRes: SeugiResponse {
    let workspaceId: String
    let workspaceName: String
    let workspaceImageUrl: String
    let workspaceAdmin: Int
    let middleAdmin: [Int]
    let teacher: [Int]
    let student: [Int]
    
    func toEntity() -> Workspace {
        Workspace(
            workspaceId: workspaceId,
            workspaceName: workspaceName,
            workspaceImageUrl: workspaceImageUrl,
            workspaceAdmin: workspaceAdmin,
            middleAdmin: middleAdmin,
            teacher: teacher,
            student: student
        )
    }
}
