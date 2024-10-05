import Foundation

public struct LogoutReq: Encodable {
    public let fcmToken: String
    public init(fcmToken: String) {
        self.fcmToken = fcmToken
    }
}
