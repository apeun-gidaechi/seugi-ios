public protocol ChatRepository {
    func createGroupChat(_ req: CreateGroupRequest) async throws -> Int
    func getGroupChat(workspaceId: Int) async throws -> [Chat]
    func addJoined(_ req: AddJoinedRequest) async throws -> AddJoined
    func getJoined(roomId: Int) async throws -> Joined
    func outJoined(_ req: OutJoinedRequest) async throws
}
