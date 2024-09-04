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
    
    public init(member: RetrieveMember, workspaceId: String, status: String, nick: String, spot: String, belong: String, phone: String, wire: String, location: String) {
        self.member = member
        self.workspaceId = workspaceId
        self.status = status
        self.nick = nick
        self.spot = spot
        self.belong = belong
        self.phone = phone
        self.wire = wire
        self.location = location
    }
}
