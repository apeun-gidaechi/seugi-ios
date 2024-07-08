import Foundation
import Domain
import DIContainer

public final class StompManager: BaseViewModel<StompManager.StompManagerSubject> {
    public enum StompManagerSubject {}
    
    @Inject private var stompRepo: any StompRepo
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
    }
}
