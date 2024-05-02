import AuthDomainInterface

class SignUpUseCaseImpl: SignUpUseCase {
    
    private let authRepository: any AuthRepository
    
    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func callAsFunction(_ req: SignUpRequest) async throws {
        try await authRepository.signUp(req)
    }
}
