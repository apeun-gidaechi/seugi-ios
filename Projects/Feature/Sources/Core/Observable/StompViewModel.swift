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
                        self.keyValueRepo.save(
                            key: .accessToken,
                            value: String(token.split(separator: " ")[1])
                        )
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
    
    public func reissue(accessToken: String) {
        stompRepo.reissue(accessToken: accessToken)
    }
}
