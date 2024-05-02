public protocol PersonalChatDataSource {
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int
    func getGroupChat(workspaceId: Int) async throws -> [Chat]
}
