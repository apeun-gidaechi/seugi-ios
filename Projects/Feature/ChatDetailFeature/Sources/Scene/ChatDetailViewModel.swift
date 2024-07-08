import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class ChatDetailViewModel: BaseViewModel<ChatDetailViewModel.ChatDetailSubject> {
    
    public enum ChatDetailSubject {}
    
    // MARK: - Repo
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    @Inject private var stompRepo: StompRepo
    @Inject private var stompMessageRepo: StompMessageRepo
    
    // MARK: - State
    @Published var messages: FetchFlow<[Message]> = .fetching
    @Published private var page = 0
    @Published var message = ""
    
    var groupedMessages: [[Message]] {
        (messages.data ?? []).group
    }
    
    func fetchMessages(roomId: String) {
        sub(messageRepo.getMessages(roomId: roomId, page: page, size: 50)) {
            self.messages = .fetching
        } success: { res in
            self.messages = .success(res.data.messages)
        } failure: { error in
            print("❌", error)
        }
    }
    
    func sendMessage(room: Room) {
        stompMessageRepo.sendMessage(
            roomId: room.id,
            type: .message,
            message: message,
            mention: nil,
            mentionAll: nil,
            emoticon: nil
        )
        message = ""
    }
}
