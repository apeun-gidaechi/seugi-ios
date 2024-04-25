import ChatDomainInterface

final class GetJoinedUseCaseImpl: GetJoinedUseCase {
    
    private let chatRepository: any ChatRepository
    
    init(chatRepository: any ChatRepository) {
        self.chatRepository = chatRepository
    }
    
    func callAsFunction(roomId: Int) async throws -> Joined {
        try await chatRepository.getJoined(roomId: roomId)
    }
}
