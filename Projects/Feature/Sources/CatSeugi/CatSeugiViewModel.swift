import Combine
import Foundation
import Domain
import DIContainer
import SwiftUtil
import ScopeKit

private let catSeugiRoom = Room(
    id: "67177e4ac6b844040200d65c",
    workspaceId: "",
    type: .personal,
    roomAdmin: 1,
    chatName: "",
    chatRoomImg: "",
    createdAt: nil,
    chatStatusEnum: .alive,
    joinUserInfo: [],
    lastMessage: nil,
    lastMessageTimestamp: .now,
    notReadCnt: 0
)

final class CatSeugiViewModel: ObservableObject {
    @Inject private var catSeugiRepo: CatSeugiRepo
    
    @Published var messages: Flow<[Message]> = .success([
        .just(
            type: .bot,
            userId: -1,
            message: "안녕? 반갑다스기! 학교에 대한 건 뭐든 물어보라스기!",
            isFirst: true,
            isLast: false,
            joinUserCount: 1
        )
    ])
    @Published var message: String = ""
    @Published var sendMessageFlow: Flow<String> = .idle
    
    var subscriptions = Set<AnyCancellable>()
    
    func sendMessage(userId: Int) {
        self.messages = self.messages.map {
            ($0 + [
                .just(
                    userId: userId,
                    message: message,
                    isFirst: false,
                    isLast: false,
                    joinUserCount: 2
                )
            ])
            .setupIsFirstAndIsLast()
        }
        
        catSeugiRepo.sendMessage(
            .init(
                roomId: "67177e4ac6b844040200d65c", // cat seugi room id constant
                type: .message,
                message: message,
                uuid: "",
                mention: nil,
                mentionAll: nil,
                emoticon: nil
            )
        )
        .map(\.data)
        .flow(\.sendMessageFlow, on: self)
        .ignoreError()
        .sink { message in
            self.messages = self.messages.map {
                ($0 + [
                    .just(
                        type: .bot,
                        userId: -1,
                        message: message,
                        isFirst: false,
                        isLast: false,
                        joinUserCount: 1
                    )
                    .setupBotMessage(
                        room: catSeugiRoom
                    )
                ]).setupIsFirstAndIsLast()
            }
        }
        .store(in: &subscriptions)
        
        self.message = ""
    }
}
