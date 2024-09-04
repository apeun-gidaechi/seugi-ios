public struct OAuth2MemberReq: Encodable {
    public let email: String
    public let name: String
    
    public init(email: String, name: String) {
        self.email = email
        self.name = name
    }
}
