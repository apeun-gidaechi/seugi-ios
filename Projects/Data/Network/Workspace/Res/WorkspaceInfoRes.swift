import Foundation
import Domain

struct WorkspaceInfoRes: SeugiResponse {
    let workspaceId: String
    let workspaceName: String
    let workspaceImageUrl: String
    let studentCount: Int
    let teacherCount: Int
    
    func toEntity() -> WorkspaceInfo {
        WorkspaceInfo(
            workspaceId: workspaceId,
            workspaceName: workspaceName,
            workspaceImageUrl: workspaceImageUrl,
            studentCount: studentCount,
            teacherCount: teacherCount
        )
    }
}
