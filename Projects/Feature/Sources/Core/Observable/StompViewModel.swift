import SwiftUI
import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

public final class StompViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var stompRepo: StompRepo
    @Inject private var memberRepo: MemberRepo
    @Inject private var keychainRepo: KeychainRepo
    @Inject private var keyValueRepo: KeyValueRepo
    
    public init() {
        openSocket()
    }
}

extension StompViewModel {
    public func openSocket() {
        Log.info("💎 StompViewModel.subscribe")
        stompRepo.closeSocket()
        stompRepo.openSocket()
        stompRepo.reconnect(time: 10)
        self.subscribe()
    }
    
    public func subscribe() {
        stompRepo.subConnect()
            .sink { _ in
                Log.info("🤩 STOMP connected")
            }
            .store(in: &self.subscriptions)
        stompRepo.subPing()
            .sink { _ in
                Log.info("🤩 STOMP ping")
            }
            .store(in: &self.subscriptions)
        stompRepo.subDisconnect()
            .sink { _ in
                Log.info("🤩 STOMP disConnected")
                self.stompRepo.closeSocket()
            }
            .store(in: &self.subscriptions)
        stompRepo.subSendError()
            .sink { error in
                Log.error("🤩 STOMP error")
                dump(error)
            }
            .store(in: &subscriptions)
        stompRepo.subSendReciept()
            .sink { recieptId in
                Log.info("🤩 STOMP recieptId \(recieptId)")
            }
            .store(in: &subscriptions)
    }
    
    public func reissue(accessToken: String) {
        stompRepo.reissue(accessToken: accessToken)
    }
}
