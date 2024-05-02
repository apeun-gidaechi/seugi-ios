public protocol OAuthSignInUseCase {
    func callAsFunction(_ req: OAuthSignInRequest) async throws -> Token
}
