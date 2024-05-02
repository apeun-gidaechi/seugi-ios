public protocol CreatePersonalUseCase {
    func callAsFunction(_ req: CreateChatRequest) async throws -> Int
}
