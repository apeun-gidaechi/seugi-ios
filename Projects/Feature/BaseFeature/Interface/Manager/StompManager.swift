import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class StompManager: BaseViewModel<StompManager.StompManagerSubject> {
    public enum StompManagerSubject {}
    
    // MARK: - Properties
    @Inject private var stompRepo: any StompRepo
    @Inject private var stompMessageRep: StompMessageRepo
    
    // MARK: - Method
    public func openSocket() {
        log("💎 StompManager.subscribe")
        stompRepo.openSocket()
        stompRepo.subConnect()
            .sink { _ in
                log("🤩 STOMP connected")
                self.stompRepo.subPing()
                    .sink { _ in
                        log("🤩 STOMP ping")
                    }
                    .store(in: &self.subscriptions)
            }
            .store(in: &subscriptions)
        stompRepo.subDisconnect()
            .sink { _ in
                log("🤩 STOMP disConnected")
            }
            .store(in: &subscriptions)
        stompRepo.subSendError()
            .sink { error in
                log("🤩 STOMP error")
                dump(error)
            }
            .store(in: &subscriptions)
        stompRepo.subSendReciept()
            .sink { recieptId in
                log("🤩 STOMP recieptId \(recieptId)")
            }
            .store(in: &subscriptions)
    }
    
    func closeSocket() {
        stompRepo.closeSocket()
    }
}
