public struct WorkspaceMembersChart: Entity {
    public var middleAdmin: [String: [RetrieveProfile]]
    public var teachers: [String: [RetrieveProfile]]
    public var admin: [String: [RetrieveProfile]]
    public var students: [String: [RetrieveProfile]]
    
    public init(
        middleAdmin: [String: [RetrieveProfile]],
        teachers: [String: [RetrieveProfile]],
        admin: [String: [RetrieveProfile]],
        students: [String: [RetrieveProfile]]
    ) {
        self.middleAdmin = middleAdmin
        self.teachers = teachers
        self.admin = admin
        self.students = students
    }
    
    public var allTeachers: [RetrieveProfile] {
        return (Array(self.admin.values) + Array(self.middleAdmin.values) + Array(self.teachers.values)).flatMap(\.self)
    }
}
