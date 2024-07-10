import SwiftBok

@Init()
@Members()
public struct Workspace: Entity, Equatable {
    public let workspaceId: String
    public let workspaceName: String
    public let workspaceImageUrl: String
    public let workspaceAdmin: Int
    public let middleAdmin: [Int]
    public let teacher: [Int]
    public let student: [Int]
}
