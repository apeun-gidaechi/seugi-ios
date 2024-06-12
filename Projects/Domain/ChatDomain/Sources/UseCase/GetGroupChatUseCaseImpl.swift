import ChatDomainInterface

final class GetGroupChatUseCaseImpl: GetGroupChatUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(workspaceId: Int) async throws -> [Chat] {
        try await chatRepository.getGroupChat(workspaceId: workspaceId)
    }
}
