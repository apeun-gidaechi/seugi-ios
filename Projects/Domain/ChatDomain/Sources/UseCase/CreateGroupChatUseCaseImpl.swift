import ChatDomainInterface

final class CreateGroupChatUseCaseImpl: CreateGroupChatUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(_ req: CreateChatRequest) async throws -> Int {
        try await chatRepository.createGroupChat(req)
    }
}
