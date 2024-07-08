import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class ChatDetailViewModel: BaseViewModel<ChatDetailViewModel.ChatDetailSubject> {
    
    public enum ChatDetailSubject {}
    
    // MARK: - Repo
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    
    // MARK: - State
    @Published var messages: FetchFlow<[Message]> = .fetching
    @Published private var page = 0
    
    func fetchMessages(roomId: String) {
        sub(messageRepo.getMessages(roomId: roomId, page: page, size: 50)) {
            self.messages = .fetching
        } success: { res in
            self.messages = .success(res.data.messages)
        } failure: { error in
            print("❌", error)
        }
    }
}
