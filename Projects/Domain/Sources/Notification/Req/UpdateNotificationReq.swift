import Foundation

public struct UpdateNotificationReq: Encodable {
    public let id: Int
    public let title: String
    public let content: String
    
    public init(id: Int, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
