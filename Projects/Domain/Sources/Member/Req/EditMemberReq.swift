public struct EditMemberReq: Encodable {
    public let picture: String
    public let name: String
    public let birth: String
    
    public init(picture: String, name: String, birth: String) {
        self.picture = picture
        self.name = name
        self.birth = birth
    }
}
