import Foundation
import Domain
import DIContainer
import PhotosUI
import SwiftUI

public final class ChatDetailViewModel: BaseViewModel<ChatDetailViewModel.Effect> {
    
    public enum Effect {
        case messageLoaded
        case messagesFetched
    }
    
    // MARK: - Repo
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    @Inject private var stompMessageRepo: StompMessageRepo
    
    // MARK: - State
    @Published private var page: Int = 0
    /* message */
    @Published var messages: FetchFlow<[Message]> = .fetching
    @Published var message: String = ""
    
    /* photo */
    @Published var photo: PhotosPickerItem?
    
    /* left room */
    @Published var leftRoomFlow: IdleFlow<Bool> = .idle
    
    // MARK: - Parameter
    private let room: Room
    
    // MARK: - Initializer
    init(room: Room) {
        self.room = room
        super.init()
        self.fetchMessages(roomId: room.id)
        self.subscribe(roomId: room.id)
    }
    
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
        messageRepo.getMessages(roomId: roomId, page: page, size: 50).fetching {
            self.messages = .fetching
        }.success { res in
            let messages = res.data.messages
                .sorted { $0.timestamp ?? .now < $1.timestamp ?? .now }
            self.messages = .success(messages)
            self.emit(.messagesFetched)
        }.failure { error in
            Log.error("❌", error)
        }.observe(&subscriptions)
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
    
    func left(roomId: String) {
        chatRepo.leftGroup(roomId: roomId).fetching {
            self.leftRoomFlow = .fetching
        }.success { _ in
            self.leftRoomFlow = .success()
        }.failure { err in
            self.leftRoomFlow = .failure(err)
        }.observe(&subscriptions)
    }
    
    deinit {
        self.unsubscribe(roomId: room.id)
    }
}
