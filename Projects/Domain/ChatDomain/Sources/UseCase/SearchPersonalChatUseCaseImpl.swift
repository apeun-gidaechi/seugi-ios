import ChatDomainInterface

final class SearchPersonalChatUseCaseImpl: SearchPersonalChatUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(workspaceId: Int, word: String) async throws -> [Chat] {
        try await chatRepository.searchPersonalChat(workspaceId: workspaceId, word: word)
    }
}

