import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class ChatDetailViewModel: BaseViewModel<ChatDetailViewModel.ChatDetailSubject> {
    
    public enum ChatDetailSubject {
        case messageLoaded
        case messagesFetched
    }
    
    // MARK: - Repo
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    @Inject private var stompRepo: StompRepo
    @Inject private var stompMessageRepo: StompMessageRepo
    
    // MARK: - State
    @Published var messages: FetchFlow<[Message]> = .fetching
    @Published private var page = 0
    @Published var message = ""
    
    // MARK: - Method
    func subscribe(roomId: String) {
        stompMessageRepo.subGetMessage(roomId: roomId)
            .sink { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [self] res in
                if var messages = messages.data {
                    messages.append(res)
                    self.messages = .success(messages)
                    emit(.messageLoaded)
                }
            }
            .store(in: &subscriptions)
    }
    
    func unsubscribe(roomId: String) {
        stompMessageRepo.unsubGetMessage(roomId: roomId)
    }
    
    func fetchMessages(roomId: String) {
        sub(messageRepo.getMessages(roomId: roomId, page: page, size: 50)) {
            self.messages = .fetching
        } success: { res in
            let messages = res.data.messages
                .sorted { $0.timestamp ?? .now < $1.timestamp ?? .now }
            self.messages = .success(messages)
            self.emit(.messagesFetched)
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
