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
        guard let accessToken = keyValueRepo.load(key: .accessToken) as? String else { return }
        Log.info("💎 StompViewModel.subscribe")
        stompRepo.reissue(accessToken: accessToken)
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
                    .ignoreError()
                    .map(\.data)
                    .sink { token in
                        let accessToken = String(token.split(separator: " ")[1])
                        self.stompRepo.reissue(accessToken: accessToken)
//                        self.stompRepo.reconnect(time: 1)
                        self.stompRepo.openSocket()
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
