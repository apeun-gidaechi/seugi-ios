import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class ChatDetailViewModel: BaseViewModel<ChatDetailViewModel.ChatDetailSubject> {
    
    public enum ChatDetailSubject {}
    
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    
    private let roomId: String
    
    public init(roomId: String) {
        self.roomId = roomId
    }
    
    func fetchMessages() {
        messageRepo.getMessages(roomId: roomId, page: <#T##Int#>, size: <#T##Int#>)
    }
}
