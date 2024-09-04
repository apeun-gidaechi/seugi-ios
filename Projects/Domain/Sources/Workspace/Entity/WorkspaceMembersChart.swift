public struct WorkspaceMembersChart: Entity {
    public var teachers: [String: [RetrieveProfile]]
    public var students: [String: [RetrieveProfile]]
    
    public init(teachers: [String : [RetrieveProfile]], students: [String : [RetrieveProfile]]) {
        self.teachers = teachers
        self.students = students
    }
}
