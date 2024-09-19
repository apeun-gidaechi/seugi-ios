public struct LoginMemberReq: Encodable {
    public let email: String
    public let password: String
    public let token: String
    
    public init(email: String, password: String, token: String) {
        self.email = email
        self.password = password
        self.token = token
    }
}
