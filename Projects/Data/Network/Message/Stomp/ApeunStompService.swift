import Foundation
import Domain
import DIContainer
import ApeunStompKit
import ScopeKit

private let wssBaseUrl = Bundle.main.object(forInfoDictionaryKey: "WssBaseUrl") as? String ?? ""
private let url = URL(string: "\(wssBaseUrl)/stomp/chat")!

final class ApeunStompService {
    
    @Inject private var keyValueRepo: KeyValueRepo
    
    private init() {}
    private(set) lazy var stomp = ApeunStomp(
        request: .init(url: url),
        connectionHeaders: [
            "Authorization": "Bearer \(keyValueRepo.load(key: .accessToken) ?? "")",
            StompCommands.commandHeaderHeartBeat.rawValue: "0,10000"
        ]
    ).apply {
        $0.jsonDecoder = .myDecoder
    }
}

extension ApeunStompService {
    static let shared = ApeunStompService()
}
