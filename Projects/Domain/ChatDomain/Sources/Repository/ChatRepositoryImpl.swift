import ChatDomainInterface
import DIContainerInterface

final class ChatRepositoryImpl: ChatRepository {
    
    var groupChatDataSource: any GroupChatDataSource
    var personalChatDataSource: any PersonalChatDataSource
    
    public init(
        groupChatDataSource: any GroupChatDataSource,
        personalChatDataSource: any PersonalChatDataSource
    ) {
        self.groupChatDataSource = groupChatDataSource
        self.personalChatDataSource = personalChatDataSource
    }
    
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int {
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
    
    func createPersonalChat(_ req: CreateChatRequest) async throws -> Int {
        try await personalChatDataSource.createPersonalChat(req)
    }
    
    func getPersonalChat(workspaceId: Int) async throws -> [Chat] {
        try await personalChatDataSource.getPersonalChat(workspaceId: workspaceId)
    }
    
    func searchPersonalChat(workspaceId: Int, word: String) async throws -> [Chat] {
        try await personalChatDataSource.searchPersonalChat(workspaceId: workspaceId, word: word)
    }
}
