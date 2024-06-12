public protocol SendEmailCodeUseCase {
    func callAsFunction(email: String) async throws
}
