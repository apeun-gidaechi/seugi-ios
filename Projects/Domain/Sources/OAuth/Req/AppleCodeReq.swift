public struct AppleCodeReq: Encodable {
    public let code: String
    public let token: String
    public let platform: String = "IOS"
    public let name: String?
    
    public init(
        code: String,
        token: String,
        name: String?
    ) {
        self.code = code
        self.token = token
        self.name = name
    }
}
