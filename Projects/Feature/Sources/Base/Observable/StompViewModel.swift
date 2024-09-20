import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class StompManager: BaseViewModel<StompManager.Effect> {
    public enum Effect {}
    
    // MARK: - Properties
    @Inject private var stompRepo: any StompRepo
    @Inject private var stompMessageRep: StompMessageRepo
    @Inject private var memberRepo: any MemberRepo
    @Inject private var keyValueRepo: any KeyValueRepo
    @Inject private var keychainRepo: any KeychainRepo
    
    public override init() {
        super.init()
        openSocket()
    }
    
    // MARK: - Method
    public func openSocket() {
        Log.info("💎 StompManager.subscribe")
        stompRepo.openSocket()
        stompRepo.subConnect()
            .sink { _ in
                Log.info("🤩 STOMP connected")
                self.stompRepo.subPing()
                    .sink { _ in
                        Log.info("🤩 STOMP ping")
                    }
                    .store(in: &self.subscriptions)
            }
            .store(in: &subscriptions)
        stompRepo.subDisconnect()
            .sink { [self] _ in
                Log.info("🤩 STOMP disConnected")
                guard let refreshToken = keychainRepo.load(key: .refreshToken) else {
                    Log.error("🤩 STOMP disConnected - RefreshToken not founded")
                    return
                }
                memberRepo.refresh(token: refreshToken).fetching {
                    Log.info("🤩 STOMP disConnected - try to reissue !")
                }.success { res in
                    let accessToken = String(res.data.split(separator: " ")[1])
                    self.stompRepo.reissue(accessToken: accessToken)
                    self.stompRepo.reconnect(time: 1)
                    Log.info("🤩 STOMP disConnected - reconnecting...")
                }.failure { _ in
                    Log.error("🤩 STOMP disConnected - reissue failure... OTL")
                }.observe(&subscriptions)
            }
            .store(in: &subscriptions)
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
    
    func closeSocket() {
        stompRepo.closeSocket()
    }
}
