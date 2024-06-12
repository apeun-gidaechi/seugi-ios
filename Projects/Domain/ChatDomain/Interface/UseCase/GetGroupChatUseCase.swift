public protocol GetGroupChatUseCase {
    func callAsFunction(workspaceId: Int) async throws -> [Chat]
}
