import Foundation
public struct CreateTaskReq: Encodable {
    public let workspaceId: String
    public let title: String
    public let description: String
    public let dueDate: Date
    
    public init(
        workspaceId: String,
        title: String,
        description: String,
        dueDate: Date
    ) {
        self.workspaceId = workspaceId
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}
