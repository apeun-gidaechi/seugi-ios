import Foundation

public protocol MessageRepo {
    func getMessages(roomId: String, timestamp: Date?) -> APIResult<Base<GetMessageRes>>
}
