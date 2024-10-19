import Foundation

public struct Timetable: Entity {
    public let id: Int
    public let workspaceId: String
    public let grade: String
    public let classNum: String
    public let time: String
    public let subject: String
    public let date: Date
    
    public init(
        id: Int,
        workspaceId: String,
        grade: String,
        classNum: String,
        time: String,
        subject: String,
        date: Date
    ) {
        self.id = id
        self.workspaceId = workspaceId
        self.grade = grade
        self.classNum = classNum
        self.time = time
        self.subject = subject
        self.date = date
    }
}
