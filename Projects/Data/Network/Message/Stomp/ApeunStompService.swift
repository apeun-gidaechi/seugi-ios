import ApeunStompKit
import Foundation
import Domain
//
//enum ApeunStompService {
    
    let wssBaseUrl = Bundle.main.object(forInfoDictionaryKey: "WssBaseUrl") as? String ?? ""

    let url = URL(string: wssBaseUrl)!
    let stomp = ApeunStomp(request: .init(url: url))
//
//}
//
//public extension ApeunStompService {
//
//}
