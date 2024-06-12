public protocol CreatePersonalChatUseCase {
    func callAsFunction(_ req: CreateChatRequest) async throws -> Int
}
