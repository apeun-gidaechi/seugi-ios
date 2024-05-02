public protocol CreateGroupChatUseCase {
    func callAsFunction(_ req: CreateChatRequest) async throws -> Int
}
