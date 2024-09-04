public struct Workspace: Entity, Equatable {
    public let workspaceId: String
    public let workspaceName: String
    public let workspaceImageUrl: String
    public let workspaceAdmin: Int
    public let middleAdmin: [Int]
    public let teacher: [Int]
    public let student: [Int]
    
    public init(workspaceId: String, workspaceName: String, workspaceImageUrl: String, workspaceAdmin: Int, middleAdmin: [Int], teacher: [Int], student: [Int]) {
        self.workspaceId = workspaceId
        self.workspaceName = workspaceName
        self.workspaceImageUrl = workspaceImageUrl
        self.workspaceAdmin = workspaceAdmin
        self.middleAdmin = middleAdmin
        self.teacher = teacher
        self.student = student
    }
}
