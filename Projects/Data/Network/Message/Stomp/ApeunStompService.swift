import ApeunStompKit
import Foundation
import Domain

let wssBaseUrl = Bundle.main.object(forInfoDictionaryKey: "WssBaseUrl") as? String ?? ""

let url = URL(string: wssBaseUrl)!
//let stomp = ApeunStomp(request: .init(url: url))
let stomp = ApeunStomp(request: <#T##<<error type>>#>)

