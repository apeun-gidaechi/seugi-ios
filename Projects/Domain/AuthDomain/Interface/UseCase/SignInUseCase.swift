public protocol SignInUseCase {
    func callAsFunction(_ req: SignInRequest) async throws -> Token
}
