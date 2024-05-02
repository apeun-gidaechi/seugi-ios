public protocol AuthRepository {
    func signIn(_ req: SignInRequest) async throws -> Token
    func signUp(_ req: SignUpRequest) async throws
    func sendEmailCode(email: String) async throws
    func verifyEmailCode(code: String) async throws
    func oauthSignIn(_ req: OAuthSignInRequest) async throws -> Token
}
