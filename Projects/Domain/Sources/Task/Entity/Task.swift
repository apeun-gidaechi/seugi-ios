import Foundation

public struct Task: Entity {
    public let id: Int
    public let workspaceId: String
    public let title: String
    public let description: String
    public let dueDate: Date
    
    public init(
        id: Int,
        workspaceId: String,
        title: String,
        description: String,
        dueDate: Date
    ) {
        self.id = id
        self.workspaceId = workspaceId
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}
