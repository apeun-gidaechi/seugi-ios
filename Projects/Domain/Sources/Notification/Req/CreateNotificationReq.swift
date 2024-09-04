import Foundation

public struct PostNotificationReq: Encodable {
    public let title: String
    public let content: String
    public let workspaceId: String
    
    public init(title: String, content: String, workspaceId: String) {
        self.title = title
        self.content = content
        self.workspaceId = workspaceId
    }
}
