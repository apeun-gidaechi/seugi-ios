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
    public var schGrade: Int = 0 // 학년
    public var schClass: Int = 0 // 반
    public var schNumber: Int = 0 // 번호
    
    public init(
        member: RetrieveMember,
        workspaceId: String,
        status: String,
        nick: String,
        spot: String,
        belong: String,
        phone: String,
        wire: String,
        location: String,
        schGrade: Int,
        schClass: Int,
        schNumber: Int
    ) {
        self.member = member
        self.workspaceId = workspaceId
        self.status = status
        self.nick = nick
        self.spot = spot
        self.belong = belong
        self.phone = phone
        self.wire = wire
        self.location = location
        self.schGrade = schGrade
        self.schClass = schClass
        self.schNumber = schNumber
    }
}
