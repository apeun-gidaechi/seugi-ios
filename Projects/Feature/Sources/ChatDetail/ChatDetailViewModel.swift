import Foundation
import Domain
import DIContainer
import PhotosUI
import SwiftUI
import SwiftUtil
import Combine

public final class ChatDetailViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    @Inject private var stompMessageRepo: StompMessageRepo
    
    @Published var page: Int = 0
    @Published var messages: Flow<[Message]> = .fetching
    @Published var message: String = ""
    @Published var searchText = ""
    @Published var isSearching: Bool = false
    @Published var photo: PhotosPickerItem?
    @Published var leftRoomFlow: Flow<BaseVoid> = .idle
    
    private let room: Room
    
    init(room: Room) {
        self.room = room
        self.fetchMessages()
        self.subscribe()
    }
    
    deinit {
        self.unsubscribe()
    }
}

extension ChatDetailViewModel {
    var searchMessages: Flow<[Message]> {
        self.messages.map { $0.search(text: searchText) }
    }
    
    var mergedMessages: Flow<[Message]> {
        if self.isSearching {
            searchMessages
        } else {
            messages
        }
    }
}

extension ChatDetailViewModel {
    func subscribe() {
        stompMessageRepo.subGetMessage(roomId: room.id)
            .sink { [self] res in
                self.messages = self.messages.map {
                    $0 + [res]
                }
            }
            .store(in: &subscriptions)
    }
    
    func unsubscribe() {
        stompMessageRepo.unsubGetMessage(roomId: room.id)
    }
    
    func fetchMessages() {
        messageRepo.getMessages(
            roomId: room.id,
            timestamp: messages.data?.getFirstMessageTimestamp()
        )
        .map(\.data.messages)
        .map { $0.sorted { $0.timestamp ?? .now < $1.timestamp ?? .now } }
        .flow(\.messages, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
    
    func sendMessage(room: Room) {
        stompMessageRepo.sendMessage(
            .init(
                roomId: room.id,
                type: .message,
                message: message,
                uuid: "",
                mention: nil,
                mentionAll: nil,
                emoticon: nil
            )
        )
        message = ""
    }
    
    func left(roomId: String) {
        chatRepo.leftGroup(roomId: roomId)
            .flow(\.leftRoomFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
}
