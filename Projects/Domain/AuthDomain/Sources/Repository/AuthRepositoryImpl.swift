import BaseDomainInterface
import AuthDomainInterface

class AuthRepositoryImpl: AuthRepository {
    
    private let authDataSource: any AuthDataSource
    private let oauthDataSource: any OAuthDataSource
    
    init(
        authDataSource: any AuthDataSource,
        oauthDataSource: any OAuthDataSource
    ) {
        self.authDataSource = authDataSource
        self.oauthDataSource = oauthDataSource
    }
    
    func signIn(_ req: SignInRequest) async throws -> Token {
        try await authDataSource.signIn(req)
    }
    
    func signUp(_ req: SignUpRequest) async throws {
        try await authDataSource.signUp(req)
    }
    
    func sendEmailCode(email: String) async throws {
        try await authDataSource.sendEmailCode(email: email)
    }
    
    func verifyEmailCode(code: String) async throws {
        try await authDataSource.verifyEmailCode(code: code)
    }
    
    func oauthSignIn(_ req: OAuthSignInRequest) async throws -> Token {
        try await oauthDataSource.oauthSignIn(req)
    }
}
