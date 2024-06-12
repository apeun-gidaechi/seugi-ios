public protocol OAuthDataSource {
    func oauthSignIn(_ req: OAuthSignInRequest) async throws -> Token
}
