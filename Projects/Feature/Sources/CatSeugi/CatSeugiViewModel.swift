import Foundation

import Domain
import DIContainer
import SwiftUtil
import Combine

final class CatSeugiViewModel: ObservableObject {
    @Inject private var catSeugiRepo: CatSeugiRepo
    
    @Published var messages: Flow<[Message]> = .success([])
    @Published var message: String = ""
    @Published var sendMessageFlow: Flow<String> = .idle
    
    var subscriptions = Set<AnyCancellable>()
    
    func sendMessage(userId: Int) {
        self.messages = self.messages.map {
            $0 + [.just(userId: userId, message: message)]
        }
        
        catSeugiRepo.sendMessage(
            .init(text: message)
        )
        .map(\.data)
        .flow(\.sendMessageFlow, on: self)
        .ignoreError()
        .sink { message in
            self.messages = self.messages.map {
                $0 + [.just(userId: -1, message: message)]
            }
        }
        .store(in: &subscriptions)
        
        self.message = ""
    }
}
