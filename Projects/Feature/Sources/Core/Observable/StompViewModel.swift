import SwiftUI
import Foundation
import Domain
import DIContainer
import SwiftUtil
import Combine

final class StompViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    @Inject private var stompRepo: StompRepo
    
    init() {
        openSocket()
    }
}

extension StompViewModel {
    public func openSocket() {
        Log.info("💎 StompViewModel.openSocket")
        stompRepo.closeSocket()
        stompRepo.openSocket()
        stompRepo.reconnect(time: 10)
        stompRepo.subStompEvent()
            .sink { event in
                switch event {
                case .stompClientDidDisconnect:
                    Log.info("🤩 STOMP disConnected")
                case .stompClientDidConnect:
                    Log.info("🤩 STOMP connected")
                case .serverDidSendReceipt(let receiptId):
                    Log.info("🤩 STOMP recieptId \(receiptId)")
                case .serverDidSendError(let error):
                    Log.error("🤩 STOMP error")
                    dump(error)
                case .serverDidSendPing:
                    Log.info("🤩 STOMP ping")
                default:
                    break
                }
            }
            .store(in: &subscriptions)
    }
    
    public func reissue(accessToken: String) {
        stompRepo.reissue(accessToken: accessToken)
    }
}
