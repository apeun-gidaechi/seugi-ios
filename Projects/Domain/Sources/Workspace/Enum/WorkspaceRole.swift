public enum WorkspaceRole: String, Codable, Comparable {
    public static func < (lhs: WorkspaceRole, rhs: WorkspaceRole) -> Bool {
        lhs.priority < rhs.priority
    }
    
    case student = "STUDENT"
    case teacher = "TEACHER"
    case middleAdmin = "MIDDLE_ADMIN"
    case admin = "ADMIN"
    
    public var priority: Int {
        switch self {
        case .student: 0
        case .teacher: 1
        case .middleAdmin: 2
        case .admin: 3
        }
    }
    
    public static func getRole(memberId: Int, workspace: Workspace) -> WorkspaceRole? {
        if workspace.student.contains(memberId) {
            .student
        } else if workspace.teacher.contains(memberId) {
            .teacher
        } else if workspace.middleAdmin.contains(memberId) {
            .middleAdmin
        } else if workspace.workspaceAdmin == memberId {
            .admin
        } else {
            nil
        }
    }
}
