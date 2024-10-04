import Foundation

import Domain
import DIContainer
import SwiftUtil

final class CatSeugiViewModel: BaseViewModel<CatSeugiViewModel.Effect> {
    enum Effect {}
    
    @Inject private var catSeugiRepo: CatSeugiRepo
    
    @Published var messages: Flow<[Message]> = .success([])
    @Published var message: String = ""
    @Published var sendMessageFlow = Flow<String>.idle
    
    func sendMessage(userId: Int) {
        self.messages = self.messages.map {
            $0 + [.just(userId: userId, message: message)]
        }
//        self.emit(.messagesFetched)
        
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
