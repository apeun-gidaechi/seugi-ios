import Combine
import Foundation
import Domain
import DIContainer
import SwiftUtil
import ScopeKit

final class CatSeugiViewModel: ObservableObject {
    @Inject private var catSeugiRepo: CatSeugiRepo
    
    @Published var messages: Flow<[Message]> = .success([])
    @Published var message: String = ""
    @Published var sendMessageFlow: Flow<String> = .idle
    
    var subscriptions = Set<AnyCancellable>()
    
    func sendMessage(userId: Int) {
        self.messages = self.messages.map {
            $0 + [
                .just(
                    userId: userId,
                    message: message,
                    isFirst: $0.isFirstMessage(at: $0.count - 1),
                    isLast: $0.isLastMessage(at: $0.count - 1),
                    joinUserCount: 2
                )
            ]
        }
        
        catSeugiRepo.sendMessage(
            .init(text: message)
        )
        .map(\.data)
        .flow(\.sendMessageFlow, on: self)
        .ignoreError()
        .sink { message in
            self.messages = self.messages.map {
                $0 + [
                    .just(
                        userId: -1,
                        message: message,
                        isFirst: false,
                        isLast: false,
                        joinUserCount: 1
                    )
                ]
            }
        }
        .store(in: &subscriptions)
        
        self.message = ""
    }
}
