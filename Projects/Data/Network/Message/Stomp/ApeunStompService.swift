import ApeunStompKit
import Foundation
import Domain
import DIContainer
import Then

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
    ).then {
        $0.jsonDecoder = decoder
    }
}

extension ApeunStompService {
    static let shared = ApeunStompService()
}
