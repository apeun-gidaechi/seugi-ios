import ChatDomainInterface

final class OutJoinedUseCaseImpl: OutJoinedUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(_ req: OutJoinedRequest) async throws {
        try await chatRepository.outJoined(req)
    }
}
