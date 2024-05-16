public protocol PersonalChatDataSource {
    func createPersonalChat(_ req: CreateChatRequest) async throws -> Int
    func getPersonalChat(workspaceId: Int) async throws -> [Chat]
    func searchPersonalChat(workspaceId: Int, word: String) async throws -> [Chat]
}
