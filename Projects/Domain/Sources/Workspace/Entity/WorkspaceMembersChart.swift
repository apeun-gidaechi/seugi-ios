import SwiftBok

@Init()
@Members()
public struct WorkspaceMembersChart: Entity {
    public var teachers: [String: [RetrieveProfile]]
    public var students: [String: [RetrieveProfile]]
}
