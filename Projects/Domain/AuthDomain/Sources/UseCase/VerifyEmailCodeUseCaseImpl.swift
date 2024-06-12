import AuthDomainInterface

class VerifyEmailCodeUseCaseImpl: VerifyEmailCodeUseCase {
    
    private let authRepository: any AuthRepository
    
    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func callAsFunction(code: String) async throws {
        try await authRepository.verifyEmailCode(code: code)
    }
}
