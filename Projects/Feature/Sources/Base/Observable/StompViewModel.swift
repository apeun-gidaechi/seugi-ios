import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

public final class StompManager: ObservableObject {
    
    // MARK: - Properties
    @Inject private var stompRepo: any StompRepo
    @Inject private var memberRepo: any MemberRepo
    @Inject private var keychainRepo: any KeychainRepo
    
    var subscriptions = Set<AnyCancellable>()
    
    public init() {
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
                memberRepo.refresh(token: refreshToken)
                    .print()
                    .ignoreError()
                    .map(\.data)
                    .sink { token in
                        let accessToken = String(token.split(separator: " ")[1])
                        self.stompRepo.reissue(accessToken: accessToken)
                        self.stompRepo.reconnect(time: 1)
                        Log.info("🤩 STOMP disConnected - reconnecting...")
                    }
                    .store(in: &subscriptions)
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
}
