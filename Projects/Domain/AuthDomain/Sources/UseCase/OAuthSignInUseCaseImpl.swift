import AuthDomainInterface

class OAuthSignInUseCaseImpl: OAuthSignInUseCase {
    
    private let authRepository: any AuthRepository
    
    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func callAsFunction(_ req: OAuthSignInRequest) async throws -> Token {
        try await authRepository.oauthSignIn(req)
    }
}
