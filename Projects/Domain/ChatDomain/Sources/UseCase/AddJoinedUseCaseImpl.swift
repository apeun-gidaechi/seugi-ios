import ChatDomainInterface

final class AddJoinedUseCaseImpl: AddJoinedUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(_ req: AddJoinedRequest) async throws -> AddJoined {
        try await chatRepository.addJoined(req)
    }
}
