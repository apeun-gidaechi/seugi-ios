import Foundation
import SwiftBok

@Init()
@Members()
public struct UpdateNotificationReq: Encodable {
    public let id: Int
    public let title: String
    public let content: String
}
