public protocol SearchPersonalChatUseCase {
    func callAsFunction(workspaceId: Int, word: String) async throws -> [Chat]
}
