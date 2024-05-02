public protocol VerifyEmailCodeUseCase {
    func callAsFunction(code: String) async throws
}
