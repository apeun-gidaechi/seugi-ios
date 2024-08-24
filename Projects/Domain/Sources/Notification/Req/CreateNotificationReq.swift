import SwiftBok
import Foundation

@Init()
@Members()
public struct PostNotificationReq: Encodable {
    public let title: String
    public let content: String
    public let workspaceId: String
}
