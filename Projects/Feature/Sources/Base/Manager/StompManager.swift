import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class StompManager: BaseViewModel<StompManager.StompManagerSubject> {
    public enum StompManagerSubject {}
    
    // MARK: - Properties
    @Inject private var stompRepo: any StompRepo
    @Inject private var stompMessageRep: StompMessageRepo
    @Inject private var memberRepo: any MemberRepo
    @Inject private var keyValueRepo: any KeyValueRepo
    @Inject private var keychainRepo: any KeychainRepo
    
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
            .sink { [self] _ in
                log("🤩 STOMP disConnected")
                guard let refreshToken = keychainRepo.load(key: .refreshToken) as? String else {
                    log("🤩 STOMP disConnected - RefreshToken not founded")
                    return
                }
                sub(memberRepo.refresh(token: refreshToken)) {
                    log("🤩 STOMP disConnected - try to reissue !")
                } success: { res in
                    let accessToken = String(res.data.split(separator: " ")[1])
                    self.stompRepo.reissue(accessToken: accessToken)
                    self.stompRepo.reconnect(time: 1)
                    log("🤩 STOMP disConnected - reconnecting...")
                } failure: { _ in
                    log("🤩 STOMP disConnected - reissue failure... OTL")
                }
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
