import Foundation
import Domain
import DIContainer
import PhotosUI
import SwiftUtil
import Combine

final class ChatDetailViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var messageRepo: MessageRepo
    @Inject private var chatRepo: ChatRepo
    @Inject private var stompMessageRepo: StompMessageRepo
    
    @Published var messages: Flow<[Message]> = .fetching
    @Published var message: String = ""
    @Published var searchText = ""
    @Published var isSearching: Bool = false
    @Published var leftRoomFlow: Flow<BaseVoid> = .idle
    @Published var firstMessageTimestamp: Date?
    
    @Published var room: Room
    
    init(room: Room) {
        var room = room
        room.joinUserInfo.sort { $0.timestamp < $1.timestamp }
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
        print("ChatDetailViewModel.subscribe")
        stompMessageRepo.subGetMessage(roomId: room.id)
            .map { $0.toDomain() }
            .sink { message in
                print("ChatDetailViewModel.subscribe - subGetMessage() message received")
                self.messages = self.messages.map {
                    let messages = $0 + [
                        message
                            .setupAuthor(room: self.room)
                            .setupDetailText(room: self.room)
                    ]
                    return messages
                        .setupIsFirstAndIsLast()
                        .setupHasTimelabel()
                        .setupRead(joinUserInfo: self.room.joinUserInfo)
                }
                self.objectWillChange.send() // 왜 인지 모르겠는데 뷰 업데이트가 안됨. 그래서 강제로 변경사항을 알림
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
        .map { messages in
            messages
                .map { $0.toDomain() }
                .sortedByTimestamp()
                .setupIsFirstAndIsLast()
                .setupHasTimelabel()
                .setupAuthor(room: self.room)
                .setupDetailText(room: self.room)
                .setupRead(joinUserInfo: self.room.joinUserInfo)
        }
        .ignoreError()
        .flow(\.messages, on: self)
        .silentSink(in: &subscriptions)
    }
    
    func sendMessage() {
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
    
    func sendImage(url: String) {
        stompMessageRepo.sendMessage(
            .init(
                roomId: room.id,
                type: .image,
                message: message,
                uuid: "",
                mention: nil,
                mentionAll: nil,
                emoticon: nil
            )
        )
    }
    
    func left(roomId: String) {
        chatRepo.leftGroup(roomId: roomId)
            .flow(\.leftRoomFlow, on: self)
            .silentSink(in: &subscriptions)
    }
}
