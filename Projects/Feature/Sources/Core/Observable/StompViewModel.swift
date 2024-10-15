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
        self.subscribe()
    }
    
    public func reconnect() {
        Log.info("💎 StompViewModel.reconnect")
        stompRepo.closeSocket()
        
        guard let refreshToken = keychainRepo.load(key: .refreshToken) else {
            Log.error("🤩 STOMP disConnected - RefreshToken not founded")
            return
        }
        memberRepo.refresh(token: refreshToken)
            .ignoreError()
            .map(\.data)
            .sink { token in
                self.keyValueRepo.save(
                    key: .accessToken,
                    value: String(token.split(separator: " ")[1])
                )
                Log.info("🤩 STOMP disConnected - reconnecting...")
                
                self.stompRepo.reconnect(time: 10)
                self.subscribe()
            }
            .store(in: &subscriptions)
    }
    
    public func subscribe() {
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
            .sink { _ in
                Log.info("🤩 STOMP disConnected")
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
    
    public func reissue(accessToken: String) {
        stompRepo.reissue(accessToken: accessToken)
    }
}
