public protocol SignUpUseCase {
    func callAsFunction(_ req: SignUpRequest) async throws
}
