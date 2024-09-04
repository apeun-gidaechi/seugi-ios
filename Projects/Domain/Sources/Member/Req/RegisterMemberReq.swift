public struct RegisterMemberReq: Encodable {
    public let name: String
    public let email: String
    public let password: String
    public let code: String
    
    public init(name: String, email: String, password: String, code: String) {
        self.name = name
        self.email = email
        self.password = password
        self.code = code
    }
}
