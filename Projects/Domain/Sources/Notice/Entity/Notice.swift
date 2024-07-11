import SwiftBok

@Init()
@Members()
public struct Notice: Entity {
    public let id: Int
    public let workspaceId: String
    public let userName: String
    public let title: String
    public let content: String
    public let emoji: [String]
    public let creationDate: String
    public let lastModifiedDate: String
}
