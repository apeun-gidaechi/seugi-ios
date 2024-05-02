import AuthDomainInterface

class SignInUseCaseImpl: SignInUseCase {
    
    private let authRepository: any AuthRepository
    
    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func callAsFunction(_ req: SignInRequest) async throws -> Token {
        try await authRepository.signIn(req)
    }
}
