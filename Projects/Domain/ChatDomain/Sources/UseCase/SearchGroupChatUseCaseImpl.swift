import ChatDomainInterface

final class SearchGroupChatUseCaseImpl: SearchGroupChatUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(workspaceId: Int, word: String) async throws -> [Chat] {
        try await chatRepository.searchGroupChat(workspaceId: workspaceId, word: word)
    }
}

