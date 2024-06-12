import AuthDomainInterface

class SendEmailCodeUseCaseImpl: SendEmailCodeUseCase {
    
    private let authRepository: any AuthRepository
    
    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }
    
    func callAsFunction(email: String) async throws {
        try await authRepository.sendEmailCode(email: email)
    }
}
