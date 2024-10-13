import Foundation

public struct Schedule: Entity {
    public let id: Int
    public let workspaceId: String
    public let date: Date
    public let eventName: String
    public let eventContent: String
    public let grade: [Int]
    
    public init(
        id: Int,
        workspaceId: String,
        date: Date,
        eventName: String,
        eventContent: String,
        grade: [Int]
    ) {
        self.id = id
        self.workspaceId = workspaceId
        self.date = date
        self.eventName = eventName
        self.eventContent = eventContent
        self.grade = grade
    }
}
