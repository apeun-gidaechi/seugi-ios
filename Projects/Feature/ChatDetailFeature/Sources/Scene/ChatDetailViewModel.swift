import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class ChatDetailViewModel: BaseViewModel<ChatDetailViewModel.ChatDetailSubject> {
    
    public enum ChatDetailSubject {}
    
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    
    @Published var messages: FetchFlow<[Message]> = .fetching
    
    func fetchMessages(roomId: String) {
        sub(messageRepo.getMessages(roomId: roomId, page: 0, size: 50)) {
            self.messages = .fetching
        } success: { res in
            self.messages = .success(res.data.messages)
        } failure: { error in
            print("❌", error)
        }
    }
}
