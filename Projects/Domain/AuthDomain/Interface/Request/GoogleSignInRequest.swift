public struct OAuthSignInRequest: Encodable {
    public let code: String
    public let registrationId: String
    public init(code: String, registrationId: String) {
        self.code = code
        self.registrationId = registrationId
    }
}
