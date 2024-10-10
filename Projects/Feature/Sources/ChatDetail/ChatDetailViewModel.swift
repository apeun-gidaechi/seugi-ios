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
    
    @Published private var page: Int = 0
    /* message */
    @Published var messages: Flow<[Message]> = .fetching
    @Published var message: String = ""
    
    /* photo */
    @Published var photo: PhotosPickerItem?
    
    @Published var leftRoomFlow: Flow<BaseVoid> = .idle
    
    // MARK: - Parameter
    private let room: Room
    
    // MARK: - Initializer
    init(room: Room) {
        self.room = room
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
                }
            }
            .store(in: &subscriptions)
    }
    
    func unsubscribe(roomId: String) {
        stompMessageRepo.unsubGetMessage(roomId: roomId)
    }
    
    func fetchMessages(roomId: String) {
        messageRepo.getMessages(
            roomId: roomId,
            timestamp: messages.data?.getFirstMessageTimestamp()
        )
        .map(\.data.messages)
        .map { $0.sorted { $0.timestamp ?? .now > $1.timestamp ?? .now } }
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
    
    deinit {
        self.unsubscribe(roomId: room.id)
    }
}
