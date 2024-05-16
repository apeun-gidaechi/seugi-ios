public protocol ChatRepository {
    
    // MARK: - Group Chat
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int
    func getGroupChat(workspaceId: Int) async throws -> [Chat]
    func addJoined(_ req: AddJoinedRequest) async throws -> AddJoined
    func getJoined(roomId: Int) async throws -> Joined
    func outJoined(_ req: OutJoinedRequest) async throws
    
    // MARK: - Personal Chat
    func createPersonalChat(_ req: CreateChatRequest) async throws -> Int
    func getPersonalChat(workspaceId: Int) async throws -> [Chat]
    func searchPersonalChat(workspaceId: Int, word: String) async throws -> [Chat]
}
