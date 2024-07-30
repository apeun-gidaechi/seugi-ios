import Foundation
import Domain
import DIContainer

public final class StompManager: BaseViewModel<StompManager.StompManagerSubject> {
    public enum StompManagerSubject {}
    
    // MARK: - Properties
    @Inject private var stompRepo: any StompRepo
    @Inject private var stompMessageRep: StompMessageRepo
    
    // MARK: - Method
    public func openSocket() {
        debugPrint("💎 StompManager.subscribe")
        stompRepo.openSocket()
        stompRepo.subConnect()
            .sink { _ in
                debugPrint("🤩 STOMP connected")
                self.stompRepo.subPing()
                    .sink { _ in
                        debugPrint("🤩 STOMP ping")
                    }
                    .store(in: &self.subscriptions)
            }
            .store(in: &subscriptions)
        stompRepo.subDisconnect()
            .sink { _ in
                debugPrint("🤩 STOMP disConnected")
            }
            .store(in: &subscriptions)
        stompRepo.subSendError()
            .sink { error in
                debugPrint("🤩 STOMP error")
                dump(error)
            }
            .store(in: &subscriptions)
        stompRepo.subSendReciept()
            .sink { recieptId in
                debugPrint("🤩 STOMP recieptId \(recieptId)")
            }
            .store(in: &subscriptions)
    }
    
    func closeSocket() {
        stompRepo.closeSocket()
    }
}
