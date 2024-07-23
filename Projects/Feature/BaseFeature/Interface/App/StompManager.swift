import Foundation
import Domain
import DIContainer

public final class StompManager: BaseViewModel<StompManager.StompManagerSubject> {
    public enum StompManagerSubject {}
    
    @Inject private var stompRepo: any StompRepo
    @Inject private var stompMessageRep: StompMessageRepo
}

public extension StompManager {
    func subscribe() {
        print("💎 StompManager.subscribe")
        stompRepo.openSocket()
        stompRepo.subConnect()
            .sink { _ in
                print("🤩 STOMP connected")
                self.stompRepo.subPing()
                    .sink { _ in
                        print("🤩 STOMP ping")
                    }
                    .store(in: &self.subscriptions)
            }
            .store(in: &subscriptions)
        stompRepo.subDisconnect()
            .sink { _ in
                print("🤩 STOMP disConnected")
            }
            .store(in: &subscriptions)
        stompRepo.subSendError()
            .sink { error in
                print("🤩 STOMP error")
                dump(error)
            }
            .store(in: &subscriptions)
        stompRepo.subSendReciept()
            .sink { recieptId in
                print("🤩 STOMP recieptId \(recieptId)")
            }
            .store(in: &subscriptions)
    }
    
    func unsubscribe() {
//        stompRepo.unsubscribe() // TODO: Impl
    }
}
