public protocol GroupChatDataSource {
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int
    func getGroupChat(workspaceId: Int) async throws -> [Chat]
    func addJoined(_ req: AddJoinedRequest) async throws -> AddJoined
    func getJoined(roomId: Int) async throws -> Joined
    func outJoined(_ req: OutJoinedRequest) async throws
    func searchGroupChat(workspaceId: Int, word: String) async throws -> [Chat]
}
