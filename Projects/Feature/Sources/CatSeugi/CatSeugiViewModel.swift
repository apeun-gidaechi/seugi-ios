//
//  CatSeugiViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 9/12/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import Domain
import DIContainer

final class CatSeugiViewModel: BaseViewModel<CatSeugiViewModel.Effect> {
    enum Effect {
        case messagesFetched
        case sendMessageFailure
    }
    
    @Inject private var catSeugiRepo: CatSeugiRepo
    
    /* message */
    @Published var messages: FetchFlow<[Message]> = .success([])
    @Published var message: String = ""
    
    func sendMessage(userId: Int) {
        self.messages = self.messages.map {
            $0 + [.just(userId: userId, message: message)]
        }
        self.emit(.messagesFetched)
        
        catSeugiRepo.sendMessage(
            .init(text: message)
        ).success { res in
            self.messages = self.messages.map {
                $0 + [.just(userId: -1, message: res.data)]
            }
            self.emit(.messagesFetched)
        }.failure { _ in
            self.emit(.sendMessageFailure)
        }.observe(&subscriptions)
        
        self.message = ""
    }
}
