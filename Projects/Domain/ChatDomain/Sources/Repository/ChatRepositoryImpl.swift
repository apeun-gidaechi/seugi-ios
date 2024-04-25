import ChatDomainInterface
import DIContainerInterface

final class ChatRepositoryImpl: ChatRepository {
    
    var groupChatDataSource: any GroupChatDataSource
    
    public init(
        groupChatDataSource: any GroupChatDataSource
    ) {
        self.groupChatDataSource = groupChatDataSource
    }
    
    func createGroupChat(_ req: CreateGroupRequest) async throws -> Int {
        try await groupChatDataSource.createGroupChat(req)
    }
    
    func getGroupChat(workspaceId: Int) async throws -> [Chat] {
        try await groupChatDataSource.getGroupChat(workspaceId: workspaceId)
    }
    
    func addJoined(_ req: AddJoinedRequest) async throws -> ChatDomainInterface.AddJoined {
        try await groupChatDataSource.addJoined(req)
    }
    
    func getJoined(roomId: Int) async throws -> Joined {
        try await groupChatDataSource.getJoined(roomId: roomId)
    }
    
    func outJoined(_ req: OutJoinedRequest) async throws {
        try await groupChatDataSource.outJoined(req)
    }
}
