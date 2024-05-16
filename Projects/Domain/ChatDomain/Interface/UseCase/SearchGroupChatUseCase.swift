public protocol SearchGroupChatUseCase {
    func callAsFunction(workspaceId: Int, word: String) async throws -> [Chat]
}
