public struct AppleCodeReq: Encodable {
    public let code: String
    public let token: String
    public let platform: String = "IOS"
    public let name: String
    public let email: String
    
    public init(
        code: String,
        token: String,
        name: String = "",
        email: String = ""
    ) {
        self.code = code
        self.token = token
        self.name = name
        self.email = email
    }
}
