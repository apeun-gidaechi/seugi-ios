public protocol ChatRepository {
    // group chat
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int
    func getGroupChat(workspaceId: Int) async throws -> [Chat]
    func addJoined(_ req: AddJoinedRequest) async throws -> AddJoined
    func getJoined(roomId: Int) async throws -> Joined
    func outJoined(_ req: OutJoinedRequest) async throws
    // personal chat
    func createPersonalChat(_ req: CreateChatRequest) async throws -> Int
    func getPersonalChat(workspaceId: Int) async throws -> [Chat]
}

