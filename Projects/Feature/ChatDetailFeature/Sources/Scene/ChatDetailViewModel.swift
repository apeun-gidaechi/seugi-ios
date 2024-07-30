import Foundation
import Domain
import DIContainer
import BaseFeatureInterface
import PhotosUI
import SwiftUI

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
    @Inject private var fileRepo: FileRepo
    
    // MARK: - State
    @Published private var page = 0
    /* message */
    @Published var messages: FetchFlow<[Message]> = .fetching
    @Published var message = ""
    
    /* photo */
    @Published var photo: PhotosPickerItem?
    @Published var uploadFlow: IdleFlow<Bool> = .fetching
    
    // MARK: - Method
    func subscribe(roomId: String) {
        stompMessageRepo.subGetMessage(roomId: roomId)
            .sink { [self] res in
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
            debugPrint("❌", error)
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
