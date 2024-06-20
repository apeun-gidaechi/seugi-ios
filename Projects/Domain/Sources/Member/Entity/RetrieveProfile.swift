import SwiftBok

@Init()
@Members()
public struct RetrieveProfile: Entity {
    public let memberId: Int
    public let workspaceId: String
    public let status: String
    public let nick: String
    public let spot: String
    public let belong: String
    public let phone: String
    public let wire: String
    public let location: String
    
}
