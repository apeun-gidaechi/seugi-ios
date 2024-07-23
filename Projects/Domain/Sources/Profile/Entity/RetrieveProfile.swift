import SwiftBok

@Init()
@Members()
public struct RetrieveProfile: Entity {
    public var member: RetrieveMember
    public var workspaceId: String
    public var status: String
    public var nick: String
    public var spot: String
    public var belong: String
    public var phone: String
    public var wire: String
    public var location: String
}
